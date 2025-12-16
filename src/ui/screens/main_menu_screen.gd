extends RefCounted
class_name MainMenuScreen

const VerseData = preload("res://src/data/verse_data.gd")

var title_panel: Control
var settings_panel: Control
var verse_panel: Control
var verse_title_label: Label
var verse_text_label: Label
var verse_reference_label: Label
var title_play_button: Button
var title_settings_button: BaseButton
var settings_language_label: Label
var music_label: Label
var settings_back_button: Button
var settings_exit_button: Button
var pause_title_label: Label
var pause_resume_button: Button
var pause_main_menu_button: Button
var pause_settings_button: Button
var language_option: OptionButton
var music_slider: HSlider
var answer_timer_label: Label
var question_panel: Control
var verse_data: VerseData
var translator: Callable


func _init(
	title_panel: Control = null,
	settings_panel: Control = null,
	verse_panel: Control = null,
	verse_title_label: Label = null,
	verse_text_label: Label = null,
	verse_reference_label: Label = null,
	title_play_button: Button = null,
	title_settings_button: BaseButton = null,
	settings_language_label: Label = null,
	music_label: Label = null,
	settings_back_button: Button = null,
	settings_exit_button: Button = null,
	pause_title_label: Label = null,
	pause_resume_button: Button = null,
	pause_main_menu_button: Button = null,
	pause_settings_button: Button = null,
	language_option: OptionButton = null,
	music_slider: HSlider = null,
	answer_timer_label: Label = null,
	question_panel: Control = null,
	verse_data: VerseData = null,
	translator: Callable = Callable()
) -> void:
	self.title_panel = title_panel
	self.settings_panel = settings_panel
	self.verse_panel = verse_panel
	self.verse_title_label = verse_title_label
	self.verse_text_label = verse_text_label
	self.verse_reference_label = verse_reference_label
	self.title_play_button = title_play_button
	self.title_settings_button = title_settings_button
	self.settings_language_label = settings_language_label
	self.music_label = music_label
	self.settings_back_button = settings_back_button
	self.settings_exit_button = settings_exit_button
	self.pause_title_label = pause_title_label
	self.pause_resume_button = pause_resume_button
	self.pause_main_menu_button = pause_main_menu_button
	self.pause_settings_button = pause_settings_button
	self.language_option = language_option
	self.music_slider = music_slider
	self.answer_timer_label = answer_timer_label
	self.question_panel = question_panel
	self.verse_data = verse_data
	self.translator = translator


func apply_language_texts(current_language: String, set_language_callable: Callable) -> void:
	var is_pt := current_language == "pt"
	set_language_callable.call(current_language)
	_set_button_label(title_play_button, translator.call("Play", "Jogar"))
	if verse_title_label:
		verse_title_label.text = translator.call("Verse of the Day", "Verso do dia")

	settings_language_label.text = translator.call("Language", "Idioma")
	music_label.text = translator.call("Music Volume", "Volume da musica")

	# Sync dropdown selection to current language
	language_option.select(1 if is_pt else 0)

	pause_title_label.text = translator.call("Paused", "Pausado")
	pause_resume_button.text = translator.call("Resume", "Retomar")
	pause_main_menu_button.text = translator.call("Main Menu", "Menu principal")
	_set_button_label(settings_back_button, translator.call("Back", "Voltar"))
	_set_button_label(settings_exit_button, translator.call("Exit Game", "Sair do jogo"))


func _set_button_label(button: BaseButton, text: String) -> void:
	if button == null or not is_instance_valid(button):
		return
	var label := button.get_node_or_null("Label") as Label
	if label:
		label.text = text
		if button is Button:
			(button as Button).text = ""
	elif button is Button:
		(button as Button).text = text


func update_verse_of_day(current_language: String, today_key: String) -> void:
	if (
		verse_panel == null
		or verse_title_label == null
		or verse_text_label == null
		or verse_reference_label == null
	):
		return
	var verse: Dictionary = verse_data.get_for_key(today_key, current_language)
	if verse.is_empty():
		verse_panel.visible = false
		return
	verse_panel.visible = true
	verse_title_label.text = translator.call("Verse of the Day", "Verso do dia")
	var localized_text := ""
	if verse.has("text") and typeof(verse["text"]) == TYPE_DICTIONARY:
		var t := verse["text"] as Dictionary
		localized_text = str(t.get(current_language, t.get("en", "")))
	else:
		localized_text = str(verse.get("text", ""))
	verse_text_label.text = localized_text
	verse_reference_label.text = str(verse.get("reference", ""))


func setup_accessible_text() -> void:
	if verse_text_label:
		verse_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		verse_text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_reference_label:
		verse_reference_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_title_label:
		verse_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if answer_timer_label:
		answer_timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func show_title() -> void:
	if title_panel:
		title_panel.visible = true
	if settings_panel:
		settings_panel.visible = false
	if question_panel:
		question_panel.visible = false
