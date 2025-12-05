extends RefCounted
class_name MainMenuScreen

const VerseData = preload("res://src/data/verse_data.gd")

var title_panel: Control
var settings_panel: Control
var player_select_panel: Control
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
var player_select_title: Label
var player_count_option: OptionButton
var player_info_label: Label
var player_start_button: Button
var pause_title_label: Label
var pause_resume_button: Button
var pause_main_menu_button: Button
var pause_settings_button: Button
var language_option: OptionButton
var music_slider: HSlider
var answer_timer_label: Label
var final_wager_label: Label
var final_wager_input: LineEdit
var final_wager_button: Button
var final_clue_button: Button
var game_root: Control
var question_panel: Control
var verse_data: VerseData
var translator: Callable


func _init(
	title_panel: Control,
	settings_panel: Control,
	player_select_panel: Control,
	verse_panel: Control,
	verse_title_label: Label,
	verse_text_label: Label,
	verse_reference_label: Label,
	title_play_button: Button,
	title_settings_button: BaseButton,
	settings_language_label: Label,
	music_label: Label,
	settings_back_button: Button,
	settings_exit_button: Button,
	player_select_title: Label,
	player_count_option: OptionButton,
	player_info_label: Label,
	player_start_button: Button,
	pause_title_label: Label,
	pause_resume_button: Button,
	pause_main_menu_button: Button,
	pause_settings_button: Button,
	language_option: OptionButton,
	music_slider: HSlider,
	answer_timer_label: Label,
	final_wager_label: Label,
	final_wager_input: LineEdit,
	final_wager_button: Button,
	final_clue_button: Button,
	game_root: Control,
	question_panel: Control,
	verse_data: VerseData,
	translator: Callable
) -> void:
	self.title_panel = title_panel
	self.settings_panel = settings_panel
	self.player_select_panel = player_select_panel
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
	self.player_select_title = player_select_title
	self.player_count_option = player_count_option
	self.player_info_label = player_info_label
	self.player_start_button = player_start_button
	self.pause_title_label = pause_title_label
	self.pause_resume_button = pause_resume_button
	self.pause_main_menu_button = pause_main_menu_button
	self.pause_settings_button = pause_settings_button
	self.language_option = language_option
	self.music_slider = music_slider
	self.answer_timer_label = answer_timer_label
	self.final_wager_label = final_wager_label
	self.final_wager_input = final_wager_input
	self.final_wager_button = final_wager_button
	self.final_clue_button = final_clue_button
	self.game_root = game_root
	self.question_panel = question_panel
	self.verse_data = verse_data
	self.translator = translator


func apply_language_texts(current_language: String, set_language_callable: Callable) -> void:
	var is_pt := current_language == "pt"
	set_language_callable.call(current_language)
	if title_play_button:
		if title_play_button is Button:
			(title_play_button as Button).text = ""
	if title_settings_button:
		if title_settings_button is Button:
			(title_settings_button as Button).text = ""
	if verse_title_label:
		verse_title_label.text = translator.call("Verse of the Day", "Verso do dia")

	settings_language_label.text = translator.call("Language", "Idioma")
	music_label.text = translator.call("Music Volume", "Volume da musica")
	settings_back_button.text = translator.call("Back", "Voltar")
	settings_exit_button.text = translator.call("Exit Game", "Sair do jogo")
	player_select_title.text = translator.call("Select Players", "Selecionar jogadores")
	player_start_button.text = translator.call("Start Game", "Iniciar jogo")

	# Sync dropdown selection to current language
	language_option.select(1 if is_pt else 0)

	pause_title_label.text = translator.call("Paused", "Pausado")
	pause_resume_button.text = translator.call("Resume", "Retomar")
	pause_main_menu_button.text = translator.call("Main Menu", "Menu principal")
	pause_settings_button.text = translator.call("Settings", "Configuracoes")
	if final_wager_label:
		final_wager_label.text = translator.call("Set Final Wager", "Definir aposta final")
	if final_wager_input:
		final_wager_input.placeholder_text = translator.call("Enter wager", "Digite a aposta")
	if final_wager_button:
		final_wager_button.text = translator.call("Set Wager", "Confirmar aposta")
	if final_clue_button:
		final_clue_button.text = translator.call("Get Clue (-10%)", "Dica (-10%)")


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
	if player_select_panel:
		player_select_panel.visible = false
	if game_root:
		game_root.visible = false
	if question_panel:
		question_panel.visible = false
