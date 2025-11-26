extends Control

@export var game_font: Font = preload("res://fonts/Comic Sans MS.ttf")
@export var title_texture: Texture2D = preload("res://game title.png")
@export var bible_character_textures: Array[Texture2D] = []

const LoadedBibleData = preload("res://scripts/bible_data.gd")
const VerseData = preload("res://scripts/verse_data.gd")
const MUSIC_BACKGROUND := preload("res://music/background music.mp3")
const MUSIC_QUESTION := preload("res://music/question music.mp3")
const SFX_CORRECT := preload("res://music/correct.mp3")
const SFX_WRONG := preload("res://music/wrong answer.mp3")
const SFX_SELECT := preload("res://music/select_001.ogg")
const TTS_VOLUME := 80.0
const TEAM_COLORS := [Color(0.9, 0.2, 0.2), Color(0.2, 0.45, 0.95), Color(0.15, 0.75, 0.35)]  # Red  # Blue  # Green

const QUESTION_CHAR_DELAY := 0.03
const AI_BUZZ_DELAY := 5.0
const ANSWER_TIME := 30.0
const ROUND_VALUES := [[400, 800, 1200], [800, 1200, 2000]]
const ROUND_CLUE_COUNT := 3
# UI references
@onready var title_panel: Control = get_node_or_null("TitlePanel")
@onready var title_play_button: Button = get_node_or_null("TitlePanel/VBox/PlayButton")
@onready var title_settings_button: Button = get_node_or_null("TitlePanel/VBox/SettingsButton")
@onready var title_logo: TextureRect = get_node_or_null("TitlePanel/VBox/TitleLogo")
@onready var title_logo_main: TextureRect = get_node_or_null("RootVBox/TitleLogoMain")
@onready var title_screen_title: Label = get_node_or_null("TitlePanel/VBox/Title")

@onready var settings_panel: Control = get_node_or_null("SettingsPanel")
@onready
var settings_title_label: Label = get_node_or_null("SettingsPanel/Content/VBox/SettingsTitle")
@onready
var settings_language_label: Label = get_node_or_null("SettingsPanel/Content/VBox/LanguageLabel")
@onready
var language_option: OptionButton = get_node_or_null("SettingsPanel/Content/VBox/LanguageOption")
@onready var music_slider: HSlider = get_node_or_null("SettingsPanel/Content/VBox/MusicSlider")
@onready var music_label: Label = get_node_or_null("SettingsPanel/Content/VBox/MusicLabel")
@onready var settings_back_button: Button = get_node_or_null("SettingsPanel/Content/VBox/BackButton")
@onready var settings_exit_button: Button = get_node_or_null("SettingsPanel/Content/VBox/ExitButton")

@onready var player_select_panel: Control = get_node_or_null("PlayerSelectPanel")
@onready
var player_count_option: OptionButton = get_node_or_null("PlayerSelectPanel/VBox/PlayerCount")
@onready var player_start_button: Button = get_node_or_null("PlayerSelectPanel/VBox/StartButton")
@onready var player_info_label: Label = get_node_or_null("PlayerSelectPanel/VBox/InfoLabel")
@onready var player_select_title: Label = get_node_or_null("PlayerSelectPanel/VBox/SelectTitle")

@onready var music_player: AudioStreamPlayer = get_node_or_null("MusicPlayer")
@onready var question_music_player: AudioStreamPlayer = get_node_or_null("QuestionMusicPlayer")
@onready var sfx_correct_player: AudioStreamPlayer = get_node_or_null("CorrectSfxPlayer")
@onready var sfx_wrong_player: AudioStreamPlayer = get_node_or_null("WrongSfxPlayer")
@onready var sfx_select_player: AudioStreamPlayer = get_node_or_null("SelectSfxPlayer")
@onready var pause_menu: Control = get_node_or_null("PauseMenu")
@onready var pause_title_label: Label = get_node_or_null("PauseMenu/Panel/VBox/PauseLabel")
@onready var pause_resume_button: Button = get_node_or_null("PauseMenu/Panel/VBox/ResumeButton")
@onready var pause_main_menu_button: Button = get_node_or_null("PauseMenu/Panel/VBox/MainMenuButton")
@onready var pause_settings_button: Button = get_node_or_null("PauseMenu/Panel/VBox/SettingsButton")

# Game UI
@onready var game_root: Control = get_node_or_null("RootVBox")
@onready var title_label: Label = get_node_or_null("RootVBox/TitleLabel")
@onready var scoreboard: HBoxContainer = get_node_or_null("RootVBox/Scoreboard")
@onready var turn_label: Label = get_node_or_null("RootVBox/TurnLabel")
@onready var board_grid: GridContainer = get_node_or_null("RootVBox/BoardMargin/BoardGrid")

@onready var verse_panel: Control = get_node_or_null("TitlePanel/VBox/VerseOfDay")
@onready var verse_title_label: Label = get_node_or_null("TitlePanel/VBox/VerseOfDay/VerseTitle")
@onready var verse_text_label: Label = get_node_or_null("TitlePanel/VBox/VerseOfDay/VerseText")
@onready
var verse_reference_label: Label = get_node_or_null("TitlePanel/VBox/VerseOfDay/VerseReference")

@onready var question_panel: PanelContainer = get_node_or_null("QuestionPanel")
@onready
var q_category_label: Label = get_node_or_null("QuestionPanel/QuestionVBox/QuestionCategory")
@onready var q_value_label: Label = get_node_or_null("QuestionPanel/QuestionVBox/QuestionValue")
@onready var q_text_label: Label = get_node_or_null("QuestionPanel/QuestionVBox/QuestionText")
@onready var result_label: Label = get_node_or_null("QuestionPanel/QuestionVBox/ResultLabel")
@onready var answer_timer_label: Label = get_node_or_null("QuestionPanel/AnswerTimer")
@onready var answer_buttons: Control = get_node_or_null("QuestionPanel/QuestionVBox/AnswerButtons")
@onready var answer_timer_bar = get_node_or_null("QuestionPanel/TimerBar")
@onready var final_wager_panel: Control = get_node_or_null("QuestionPanel/FinalWager")
@onready var final_wager_label: Label = get_node_or_null("QuestionPanel/FinalWager/WagerLabel")
@onready var final_wager_input: LineEdit = get_node_or_null("QuestionPanel/FinalWager/WagerInput")
@onready var final_wager_button: Button = get_node_or_null("QuestionPanel/FinalWager/SetWagerButton")
@onready var final_clue_button: Button = get_node_or_null("QuestionPanel/FinalWager/FinalClueButton")
@onready var character_left: TextureRect = get_node_or_null(
	"QuestionPanel/QuestionVBox/Characters/LeftCharacter"
)
@onready var character_right: TextureRect = get_node_or_null(
	"QuestionPanel/QuestionVBox/Characters/RightCharacter"
)

# Settings
@onready var play_button: Button = get_node_or_null("TitlePanel/PlayButton")

var answer_button_nodes: Array[Button] = []

var team_names: Array[String] = []
var players: Array[Dictionary] = []  # {name, is_ai, device_id, uses_keyboard}
var team_scores: Array[int] = []
var team_score_labels: Array[Label] = []
var team_cards: Array[PanelContainer] = []

var current_clue: Dictionary = {}
var answered_map: Dictionary = {}  # key: "catIndex-clueIndex" -> true
var current_categories: Array = []
var current_options: Array[String] = []

var is_typing_question: bool = false
var buzzed_player: int = -1
var attempted_players: Array[int] = []
var ai_buzz_timer: SceneTreeTimer
var rng := RandomNumberGenerator.new()
var current_language: String = "en"
var bible_data: LoadedBibleData = LoadedBibleData.new()
var settings_opened_from_pause: bool = false
var round_index: int = 0
var final_round: bool = false
var hidden_double_key: String = ""
var total_clues_this_round: int = 0
var current_wager: int = 0
var final_wager_player: int = -1
var final_wager_set: bool = false
var final_clue_used: bool = false
var current_turn_team: int = 0
var answering_player: int = -1
var background_rect: TextureRect
var theme_body_color: Color = Color(0.05, 0.08, 0.2)
var category_deck: Array = []
var loading_settings: bool = false
var verse_data := VerseData.new()
var question_panel_base_style: StyleBox = null
var music_volume_tween: Tween = null
const SETTINGS_PATH := "user://settings.cfg"


func _ready() -> void:
	_update_verse_of_day()
	# Hook up UI
	title_play_button.pressed.connect(_on_play_pressed)
	title_settings_button.pressed.connect(_on_settings_pressed)
	settings_back_button.pressed.connect(_on_settings_back_pressed)
	player_start_button.pressed.connect(_on_player_start_pressed)
	music_slider.value_changed.connect(_on_music_slider_changed)
	language_option.item_selected.connect(_on_language_selected)
	player_count_option.item_selected.connect(func(_idx: int) -> void: _play_select_sfx())
	pause_resume_button.pressed.connect(_on_pause_resume_pressed)
	pause_main_menu_button.pressed.connect(_on_pause_main_menu_pressed)
	pause_settings_button.pressed.connect(_on_pause_settings_pressed)
	settings_exit_button.pressed.connect(_on_exit_pressed)
	final_wager_button.pressed.connect(_on_set_wager_pressed)
	final_clue_button.pressed.connect(_on_final_clue_pressed)
	if title_texture:
		if title_logo:
			title_logo.texture = title_texture
			title_logo.custom_minimum_size = Vector2(1400, 380)
			title_logo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			title_logo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		if title_logo_main:
			title_logo_main.texture = title_texture
			title_logo_main.custom_minimum_size = Vector2(1400, 380)
			title_logo_main.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			title_logo_main.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	rng.randomize()
	set_process_input(true)
	_populate_player_count()
	_show_title()
	_init_music()
	_populate_languages()
	_load_settings()
	_apply_language_texts()
	_setup_accessible_text()
	if answer_timer_label:
		answer_timer_label.visible = false
	if answer_timer_bar:
		answer_timer_bar.visible = false
		if answer_timer_bar.has_signal("timeout"):
			if not answer_timer_bar.timeout.is_connected(_on_answer_timer_timeout):
				answer_timer_bar.timeout.connect(_on_answer_timer_timeout)
	if final_wager_panel:
		final_wager_panel.visible = false
	_apply_game_font()
	_setup_background()
	_apply_bible_theme()
	_reset_round_state()


func _get_today_key() -> String:
	var d = Time.get_date_dict_from_system()
	# Example: "2025-11-21"
	return "%04d-%02d-%02d" % [d.year, d.month, d.day]


func _get_verse_for_today() -> Dictionary:
	var key := _get_today_key()
	return verse_data.get_for_key(key, current_language)


func _update_verse_of_day():
	if (
		verse_panel == null
		or verse_title_label == null
		or verse_text_label == null
		or verse_reference_label == null
	):
		return
	var verse := _get_verse_for_today()
	if verse.is_empty():
		verse_panel.visible = false
		return
	verse_panel.visible = true
	verse_title_label.text = _t("Verse of the Day", "Verso do dia")
	var localized_text := ""
	if verse.has("text") and typeof(verse["text"]) == TYPE_DICTIONARY:
		var t := verse["text"] as Dictionary
		localized_text = str(t.get(current_language, t.get("en", "")))
	else:
		localized_text = str(verse.get("text", ""))
	verse_text_label.text = localized_text
	verse_reference_label.text = str(verse.get("reference", ""))


func _populate_player_count() -> void:
	player_count_option.clear()
	for i in range(2, 4):
		player_count_option.add_item("%d Players" % i, i)
	player_count_option.selected = 0
	_reset_round_state()
	_apply_resolution(Vector2i(1920, 1080))


func _apply_language_texts() -> void:
	var is_pt := current_language == "pt"
	LoadedBibleData.set_language(current_language)
	title_play_button.text = _t("Play", "Jogar")
	title_settings_button.text = _t("Settings", "Configuracoes")
	if verse_title_label:
		verse_title_label.text = _t("Verse of the Day", "Verso do dia")

	settings_language_label.text = _t("Language", "Idioma")
	music_label.text = _t("Music Volume", "Volume da musica")
	settings_back_button.text = _t("Back", "Voltar")
	settings_exit_button.text = _t("Exit Game", "Sair do jogo")
	final_wager_label.text = _t("Set Final Wager", "Definir aposta final")
	final_wager_input.placeholder_text = _t("Enter wager", "Digite a aposta")
	final_wager_button.text = _t("Set Wager", "Confirmar aposta")
	final_clue_button.text = _t("Get Clue (-10%)", "Dica (-10%)")

	player_select_title.text = _t("Select Players", "Selecionar jogadores")
	player_start_button.text = _t("Start Game", "Iniciar jogo")
	_update_player_info_label()

	# Sync dropdown selection to current language
	language_option.select(1 if is_pt else 0)

	pause_title_label.text = _t("Paused", "Pausado")
	pause_resume_button.text = _t("Resume", "Retomar")
	pause_main_menu_button.text = _t("Main Menu", "Menu principal")
	pause_settings_button.text = _t("Settings", "Configuracoes")
	_update_verse_of_day()


func _setup_accessible_text() -> void:
	q_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	q_text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	q_text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	q_text_label.add_theme_font_size_override("font_size", 32)
	if verse_text_label:
		verse_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		verse_text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_reference_label:
		verse_reference_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_title_label:
		verse_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	q_category_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	q_value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	answer_timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _apply_font_override(control: Control) -> void:
	if game_font == null or control == null:
		return
	control.add_theme_font_override("font", game_font)


func _apply_body_color(control: Control) -> void:
	if control == null:
		return
	control.add_theme_color_override("font_color", theme_body_color)


func _apply_game_font() -> void:
	if game_font == null:
		return

	var labels: Array[Control] = [
		verse_title_label,
		verse_text_label,
		verse_reference_label,
		title_screen_title,
		settings_title_label,
		title_label,
		q_category_label,
		q_value_label,
		q_text_label,
		result_label,
		turn_label,
		player_select_title,
		settings_language_label,
		music_label,
		pause_title_label,
		player_info_label,
		final_wager_label,
		final_wager_panel,
		final_wager_input
	]

	for l in labels:
		_apply_font_override(l)

	var buttons: Array[BaseButton] = [
		title_play_button,
		title_settings_button,
		settings_back_button,
		settings_exit_button,
		player_start_button,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		language_option,
		player_count_option,
		final_wager_button,
		final_clue_button
	]

	for b in buttons:
		_apply_font_override(b)


func _setup_background() -> void:
	if background_rect and is_instance_valid(background_rect):
		return
	background_rect = TextureRect.new()
	background_rect.name = "BackgroundGradient"
	background_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background_rect.z_index = -100
	background_rect.anchor_right = 1.0
	background_rect.anchor_bottom = 1.0
	background_rect.offset_left = 0
	background_rect.offset_top = 0
	background_rect.offset_right = 0
	background_rect.offset_bottom = 0
	background_rect.stretch_mode = TextureRect.STRETCH_SCALE
	background_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE

	var grad := Gradient.new()
	grad.colors = PackedColorArray([Color(1.0, 0.85, 0.2), Color(1.0, 0.72, 0.1)])
	grad.offsets = PackedFloat32Array([0.0, 1.0])
	var grad_tex := GradientTexture2D.new()
	grad_tex.gradient = grad
	grad_tex.width = 1024
	grad_tex.height = 1024
	background_rect.texture = grad_tex

	add_child(background_rect)
	move_child(background_rect, 0)


func _apply_bible_theme() -> void:
	var title_color := Color(0.05, 0.08, 0.2)
	if title_screen_title:
		title_screen_title.add_theme_color_override("font_color", title_color)
		title_screen_title.add_theme_font_size_override("font_size", 48)
		title_screen_title.visible = false
	if title_label:
		title_label.add_theme_color_override("font_color", title_color)
		title_label.add_theme_font_size_override("font_size", 42)
		title_label.visible = false

	var primary_controls: Array = [
		title_play_button,
		title_settings_button,
		verse_title_label,
		verse_text_label,
		verse_reference_label,
		settings_language_label,
		music_label,
		settings_back_button,
		settings_exit_button,
		player_select_title,
		player_count_option,
		player_info_label,
		player_start_button,
		title_label,
		turn_label,
		q_category_label,
		q_value_label,
		q_text_label,
		result_label,
		pause_title_label,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		language_option,
		music_slider,
		answer_timer_label
	]
	for ctrl in primary_controls:
		if ctrl and ctrl is Control:
			_apply_body_color(ctrl)
			(ctrl as Control).add_theme_font_size_override("font_size", 28)
	if settings_language_label:
		settings_language_label.add_theme_font_size_override("font_size", 32)
	if music_label:
		music_label.add_theme_font_size_override("font_size", 32)

	_style_timer_bar()

	var parchment := StyleBoxFlat.new()
	parchment.bg_color = Color(1.0, 0.92, 0.65)
	parchment.border_color = Color(0, 0, 0, 0)
	parchment.border_width_left = 0
	parchment.border_width_right = 0
	parchment.border_width_top = 0
	parchment.border_width_bottom = 0
	parchment.shadow_size = 8
	parchment.shadow_color = Color(0, 0, 0, 0.12)
	parchment.corner_radius_top_left = 12
	parchment.corner_radius_top_right = 12
	parchment.corner_radius_bottom_left = 12
	parchment.corner_radius_bottom_right = 12

	if question_panel:
		question_panel_base_style = parchment.duplicate()
		question_panel.add_theme_stylebox_override("panel", question_panel_base_style.duplicate())

	var pause_panel := (
		pause_menu.get_node("Panel") if pause_menu and pause_menu.has_node("Panel") else null
	)
	if pause_panel:
		pause_panel.add_theme_stylebox_override("panel", parchment.duplicate())

	var button_normal := StyleBoxFlat.new()
	button_normal.bg_color = Color(0.92, 0.18, 0.18)
	button_normal.border_color = Color(0.05, 0.08, 0.2)
	button_normal.border_width_left = 3
	button_normal.border_width_right = 3
	button_normal.border_width_top = 3
	button_normal.border_width_bottom = 3
	button_normal.corner_radius_top_left = 10
	button_normal.corner_radius_top_right = 10
	button_normal.corner_radius_bottom_left = 10
	button_normal.corner_radius_bottom_right = 10

	var button_hover := button_normal.duplicate()
	button_hover.bg_color = Color(1.0, 0.25, 0.25)

	var button_pressed := button_normal.duplicate()
	button_pressed.bg_color = Color(0.75, 0.12, 0.12)

	var button_disabled := button_normal.duplicate()
	button_disabled.bg_color = Color(0.7, 0.7, 0.7)
	button_disabled.border_color = Color(0.4, 0.4, 0.4)

	var button_controls := [
		title_play_button,
		title_settings_button,
		settings_back_button,
		settings_exit_button,
		player_start_button,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		final_wager_button,
		final_clue_button
	]
	for btn in button_controls:
		if btn:
			btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			btn.custom_minimum_size = Vector2(320, 72)
			btn.add_theme_stylebox_override("normal", button_normal)
			btn.add_theme_stylebox_override("hover", button_hover)
			btn.add_theme_stylebox_override("pressed", button_pressed)
			btn.add_theme_stylebox_override("disabled", button_disabled)


func _team_color(idx: int) -> Color:
	if idx < TEAM_COLORS.size():
		return TEAM_COLORS[idx]
	# Cycle colors if ever needed
	return TEAM_COLORS[idx % TEAM_COLORS.size()]


func _apply_team_card_style(card: PanelContainer, color: Color, highlighted: bool) -> void:
	if card == null or not is_instance_valid(card):
		return
	var style := StyleBoxFlat.new()
	style.bg_color = Color(1, 1, 1)
	style.border_color = color
	var border := 4 if highlighted else 2
	style.border_width_left = border
	style.border_width_right = border
	style.border_width_top = border
	style.border_width_bottom = border
	style.shadow_size = 14 if highlighted else 6
	var shadow_alpha := 0.18 if highlighted else 0.08
	style.shadow_color = Color(0, 0, 0, shadow_alpha)
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_left = 12
	style.corner_radius_bottom_right = 12
	card.add_theme_stylebox_override("panel", style)


func _style_timer_bar() -> void:
	if answer_timer_bar == null or not is_instance_valid(answer_timer_bar):
		return

	if answer_timer_bar is TimerBar:
		answer_timer_bar.duration_seconds = ANSWER_TIME
		answer_timer_bar.set_time_left(ANSWER_TIME)
		answer_timer_bar.visible = false


func _refresh_team_highlight() -> void:
	for i in range(team_cards.size()):
		var card := team_cards[i]
		var color := _team_color(i)
		var is_active := i == current_turn_team
		_apply_team_card_style(card, color, is_active)


func _set_active_team(idx: int) -> void:
	if idx < 0 or idx >= team_cards.size():
		current_turn_team = clamp(idx, 0, max(0, team_cards.size() - 1))
	else:
		current_turn_team = idx
	_refresh_team_highlight()


func _set_question_panel_color(color: Color) -> void:
	if (
		question_panel == null
		or not is_instance_valid(question_panel)
		or question_panel_base_style == null
	):
		return
	var styled := question_panel_base_style.duplicate()
	styled.shadow_color = Color(color.r, color.g, color.b, 0.28)
	styled.shadow_size = 20
	question_panel.add_theme_stylebox_override("panel", styled)


func _reset_question_panel_color() -> void:
	if (
		question_panel == null
		or not is_instance_valid(question_panel)
		or question_panel_base_style == null
	):
		return
	question_panel.add_theme_stylebox_override("panel", question_panel_base_style.duplicate())


func _init_music() -> void:
	var bus_idx := AudioServer.get_bus_index("Master")
	var db := AudioServer.get_bus_volume_db(bus_idx)
	var half := (music_slider.min_value + music_slider.max_value) * 0.5
	music_slider.value = clamp(
		float(db if db != 0 else half), music_slider.min_value, music_slider.max_value
	)
	music_player.stream = MUSIC_BACKGROUND
	if music_player.stream:
		music_player.stream.loop = true

	question_music_player.stream = MUSIC_QUESTION
	if question_music_player.stream:
		question_music_player.stream.loop = true
	question_music_player.stop()

	sfx_correct_player.stream = SFX_CORRECT
	sfx_wrong_player.stream = SFX_WRONG
	sfx_select_player.stream = SFX_SELECT

	_play_background_music()


func _play_background_music() -> void:
	_stop_question_music()
	if not music_player.playing:
		music_player.play()


func _stop_background_music() -> void:
	if music_player.playing:
		music_player.stop()


func _play_question_music() -> void:
	_stop_background_music()
	if question_music_player.stream and not question_music_player.playing:
		question_music_player.play()


func _stop_question_music() -> void:
	if question_music_player.playing:
		question_music_player.stop()


func _begin_question_audio() -> void:
	_play_question_music()


func _end_question_audio() -> void:
	_stop_question_music()
	_play_background_music()


func _play_correct_sfx() -> void:
	if sfx_correct_player.stream:
		sfx_correct_player.stop()
		sfx_correct_player.play()


func _play_wrong_sfx() -> void:
	_stop_question_music()
	if sfx_wrong_player.stream:
		sfx_wrong_player.stop()
		sfx_wrong_player.play()
	_play_question_music()


func _play_select_sfx() -> void:
	if sfx_select_player.stream:
		sfx_select_player.stop()
		sfx_select_player.play()


func _show_title() -> void:
	title_panel.visible = true
	settings_panel.visible = false
	player_select_panel.visible = false
	game_root.visible = false
	question_panel.visible = false
	_close_pause_menu()


func _on_play_pressed() -> void:
	_play_select_sfx()
	title_panel.visible = false
	settings_panel.visible = false
	player_select_panel.visible = false
	_start_game()

	# Auto-detect controllers and set player count (min 2, max 3).
	var joypads := Input.get_connected_joypads()
	var count: int = clamp(joypads.size() + 1, 2, 3)  # keyboard + controllers
	var idx: int = count - 2
	if idx >= 0 and idx < player_count_option.item_count:
		player_count_option.select(idx)
	_update_player_info_label()


func _on_settings_pressed() -> void:
	_play_select_sfx()
	settings_opened_from_pause = false
	title_panel.visible = false
	settings_panel.visible = true
	player_select_panel.visible = false
	pause_menu.visible = false


func _on_settings_back_pressed() -> void:
	_play_select_sfx()
	if settings_opened_from_pause:
		settings_opened_from_pause = false
		settings_panel.visible = false
		_open_pause_menu()
	else:
		_show_title()


func _start_game() -> void:
	_reset_round_state()
	_setup_players(3)
	player_select_panel.visible = false
	game_root.visible = true
	question_panel.visible = false
	_build_teams()
	_build_board()
	_set_header_visible(true)


func _input(event: InputEvent) -> void:
	# Handle Escape/UI cancel to toggle pause/menu return.
	if _handle_escape_input(event):
		return


func _can_open_pause_menu() -> bool:
	return player_select_panel.visible or game_root.visible or question_panel.visible


func _open_pause_menu() -> void:
	settings_panel.visible = false
	pause_menu.visible = true
	pause_resume_button.grab_focus()


func _close_pause_menu() -> void:
	pause_menu.visible = false


func _on_pause_resume_pressed() -> void:
	_play_select_sfx()
	_close_pause_menu()


func _on_pause_main_menu_pressed() -> void:
	_play_select_sfx()
	_restart_to_main_menu()


func _on_pause_settings_pressed() -> void:
	_play_select_sfx()
	settings_opened_from_pause = true
	_close_pause_menu()
	settings_panel.visible = true


func _populate_languages() -> void:
	language_option.clear()
	language_option.add_item("English", 0)
	language_option.add_item("Português (BR)", 1)
	language_option.selected = 0


func _load_settings() -> void:
	loading_settings = true
	var cfg := ConfigFile.new()
	var err := cfg.load(SETTINGS_PATH)
	if err == OK:
		current_language = str(cfg.get_value("general", "language", current_language))
		var saved_db := float(cfg.get_value("audio", "music_db", music_slider.value))
		music_slider.value = clamp(saved_db, music_slider.min_value, music_slider.max_value)
		language_option.select(1 if current_language == "pt" else 0)
		_on_music_slider_changed(music_slider.value)
	loading_settings = false


func _save_settings() -> void:
	if loading_settings:
		return
	var cfg := ConfigFile.new()
	cfg.set_value("general", "language", current_language)
	cfg.set_value("audio", "music_db", music_slider.value)
	cfg.save(SETTINGS_PATH)


func _apply_resolution(res: Vector2i) -> void:
	if res == Vector2i.ZERO:
		return
	var win := get_window()
	if win == null:
		return
	win.content_scale_size = res

	# Avoid resizing the embedded editor window; only resize standalone/runtime windows.
	if OS.has_feature("editor"):
		return

	win.unresizable = false
	win.mode = Window.MODE_WINDOWED
	win.size = res
	win.move_to_center()


func _on_language_selected(index: int) -> void:
	_play_select_sfx()
	current_language = "pt" if index == 1 else "en"
	LoadedBibleData.set_language(current_language)
	_apply_language_texts()
	_save_settings()
	_build_board()
	_build_teams()
	if final_wager_panel:
		final_wager_panel.visible = false


func _on_set_wager_pressed() -> void:
	if not final_round or final_wager_player == -1:
		return
	if final_wager_player >= team_scores.size():
		return
	var raw: String = ""
	if final_wager_input:
		raw = final_wager_input.text
	var wager: int = int(raw)
	var max_wager: int = max(100, abs(team_scores[final_wager_player]))
	if max_wager <= 0:
		max_wager = 100
	var clamped: int = clamp(wager, 100, max_wager)
	current_wager = clamped
	if final_wager_input:
		final_wager_input.text = str(current_wager)
	final_wager_set = true
	if final_wager_panel:
		final_wager_panel.visible = false
	if final_clue_button:
		final_clue_button.disabled = false
	_show_result(
		_t("Wager set: %d" % current_wager, "Aposta definida: %d" % current_wager),
		Color(0.2, 0.8, 0.4)
	)
	_open_answer_buttons_for(final_wager_player)
	_start_answer_timer()


func _on_final_clue_pressed() -> void:
	if not final_round or not final_wager_set or final_clue_used or final_wager_player == -1:
		return
	if current_wager <= 0:
		return
	if final_wager_player >= team_scores.size():
		return
	final_clue_used = true
	if final_clue_button:
		final_clue_button.disabled = true
	var penalty := int(ceil(float(current_wager) * 0.1))
	team_scores[final_wager_player] -= penalty
	if final_wager_player < team_score_labels.size():
		_set_score_label(final_wager_player)
	var ans: String = str(current_clue.get("answer", ""))
	var hint: String = ""
	if ans.length() > 0:
		var first_char := ans[0]
		hint = (
			_t("Clue: starts with %s (%d letters)", "Dica: comeca com %s (%d letras)")
			% [first_char, ans.length()]
		)
	else:
		hint = _t("Clue used.", "Dica usada.")
	_show_result(hint + _t(" (-10% wager)", " (-10% da aposta)"), Color(0.9, 0.7, 0.1))


func _on_player_start_pressed() -> void:
	_play_select_sfx()
	_start_game()


func _on_music_slider_changed(value: float) -> void:
	_set_music_volume_db(value)
	_save_settings()


func _set_music_volume_db(target_db: float) -> void:
	var bus_idx := AudioServer.get_bus_index("Master")
	var current_db := AudioServer.get_bus_volume_db(bus_idx)
	if music_volume_tween and is_instance_valid(music_volume_tween):
		music_volume_tween.kill()
	music_volume_tween = create_tween()
	music_volume_tween.tween_method(
		func(db: float) -> void: AudioServer.set_bus_volume_db(bus_idx, db),
		current_db,
		target_db,
		0.08
	)


func _setup_players(count: int) -> void:
	players.clear()
	current_turn_team = 0
	var joypads := Input.get_connected_joypads()
	var required_players: int = 3
	var joypad_index := 0

	# Player 1 is always keyboard if available.
	players.append({"name": "Player 1", "is_ai": false, "device_id": null, "uses_keyboard": true})

	for i in range(1, required_players):
		if joypad_index < joypads.size():
			var dev_id := joypads[joypad_index]
			players.append(
				{
					"name": "Player %d" % (i + 1),
					"is_ai": false,
					"device_id": dev_id,
					"uses_keyboard": false
				}
			)
			joypad_index += 1
		else:
			players.append(
				{
					"name": "Player %d (AI)" % (i + 1),
					"is_ai": true,
					"device_id": null,
					"uses_keyboard": false
				}
			)

	_update_player_info_label()

	# Sync team names from players
	var names: Array[String] = []
	for p in players:
		names.append(p["name"])
	team_names = names


func _update_player_info_label() -> void:
	var info := _t(
		"Three players always. Keyboard is Player 1 (Spacebar buzz).\n",
		"Sempre tres jogadores. Teclado e o Jogador 1 (barra de espaco).\n"
	)
	info += _t(
		"Connected controllers fill Player 2 and 3; remaining slots become AI.",
		"Controles conectados preenchem Jogador 2 e 3; vagas restantes viram IA."
	)
	player_info_label.text = info


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()


func _build_teams() -> void:
	if scoreboard == null or not is_instance_valid(scoreboard):
		push_warning("Scoreboard node missing; cannot build teams.")
		return

	_clear_children(scoreboard)
	team_scores.clear()
	team_score_labels.clear()
	team_cards.clear()

	for i in range(team_names.size()):
		var team_name: String = team_names[i].strip_edges()
		if team_name == "":
			continue  # Skip empty team names

		team_scores.append(0)

		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(260, 140)
		_apply_team_card_style(card, _team_color(i), false)

		var vbox := VBoxContainer.new()
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

		var name_label := Label.new()
		name_label.text = team_name
		_apply_font_override(name_label)
		_apply_body_color(name_label)
		name_label.add_theme_font_size_override("font_size", 28)
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		var score_label := Label.new()
		score_label.text = _t("Points: 0", "Pontos: 0")
		_apply_font_override(score_label)
		_apply_body_color(score_label)
		score_label.add_theme_font_size_override("font_size", 26)
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		vbox.add_child(name_label)
		vbox.add_child(score_label)
		card.add_child(vbox)
		scoreboard.add_child(card)

		team_score_labels.append(score_label)
		team_cards.append(card)

	if team_score_labels.size() > 0:
		_set_active_team(current_turn_team)
		turn_label.text = ""
	else:
		turn_label.text = _t("No teams configured", "Nenhum time configurado")


func _set_score_label(idx: int) -> void:
	if idx < 0 or idx >= team_score_labels.size():
		return
	team_score_labels[idx].text = _t("Points: %d", "Pontos: %d") % team_scores[idx]


func _build_board() -> void:
	if round_index >= ROUND_VALUES.size():
		_start_final_round()
		return

	question_panel.visible = false
	_set_header_visible(true)
	_show_result("", Color(0.1, 0.1, 0.1))
	turn_label.text = ""

	if board_grid == null or not is_instance_valid(board_grid):
		push_warning("Board grid node missing; cannot build board.")
		return

	_clear_children(board_grid)
	board_grid.add_theme_constant_override("h_separation", 24)
	board_grid.add_theme_constant_override("v_separation", 24)

	if category_deck.is_empty():
		category_deck = LoadedBibleData.get_categories()
	var requested: int = min(3, category_deck.size())
	current_categories.clear()
	for i in range(requested):
		current_categories.append(category_deck.pop_back())
	if current_categories.is_empty():
		return

	var num_categories := current_categories.size()
	board_grid.columns = num_categories
	var num_clues: int = min(ROUND_CLUE_COUNT, (current_categories[0]["values"] as Array).size())
	total_clues_this_round = num_categories * num_clues
	_select_hidden_double(num_categories, num_clues)

	# First row: category titles
	for cat_data: Dictionary in current_categories:
		var cat_label := Label.new()
		cat_label.text = str(cat_data["name"])
		cat_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		_apply_font_override(cat_label)
		_apply_body_color(cat_label)
		cat_label.add_theme_font_size_override("font_size", 32)
		board_grid.add_child(cat_label)

	for clue_index in range(num_clues):
		for cat_index in range(num_categories):
			var btn := Button.new()
			var score_value: int = ROUND_VALUES[round_index][clue_index]
			btn.text = str(score_value)
			btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			btn.custom_minimum_size = Vector2(300, 160)
			btn.pivot_offset = btn.custom_minimum_size * 0.5
			_apply_font_override(btn)
			_apply_body_color(btn)
			btn.add_theme_font_size_override("font_size", 36)

			btn.set_meta("cat_index", cat_index)
			btn.set_meta("clue_index", clue_index)
			btn.set_meta("score_value", score_value)

			btn.pressed.connect(func() -> void: _on_clue_button_pressed(btn))

			board_grid.add_child(btn)

	_set_board_input_enabled(true)


func _on_clue_button_pressed(button: Button) -> void:
	var cat_index: int = button.get_meta("cat_index")
	var clue_index: int = button.get_meta("clue_index")
	var key := "%d-%d" % [cat_index, clue_index]

	if answered_map.has(key):
		return  # Already used
	_play_select_sfx()
	_reset_question_panel_color()
	await _flip_card(button)
	result_label.text = ""

	if current_categories.is_empty():
		_build_board()
	if current_categories.is_empty():
		return
	if cat_index >= current_categories.size():
		return

	var cat_data: Dictionary = current_categories[cat_index] as Dictionary
	var values: Array = cat_data["values"] as Array
	var value_entry: Dictionary = values[clue_index] as Dictionary
	var pool: Array = value_entry["pool"] as Array
	if pool.is_empty():
		return
	var random_index := rng.randi_range(0, pool.size() - 1)
	var clue: Dictionary = pool[random_index] as Dictionary
	pool.remove_at(random_index)
	var question_text := str(clue["question"])
	var score_value: int = button.get_meta("score_value", value_entry["value"])
	var is_double := hidden_double_key != "" and hidden_double_key == key
	if is_double:
		score_value *= 2
		_show_result(_t("Double points!", "Pontos em dobro!"), Color(0.9, 0.7, 0.1))
	else:
		_show_result("", Color(1, 1, 1))
	current_wager = 0

	current_clue = {
		"cat_index": cat_index,
		"clue_index": clue_index,
		"value": score_value,
		"button": button,
		"answer": clue["answer"],
		"is_double": is_double
	}

	q_category_label.text = _t("Category: %s", "Categoria: %s") % str(cat_data["name"])
	q_value_label.text = _t("Value: %s", "Valor: %s") % str(score_value)
	q_text_label.text = ""
	current_options.clear()
	if answer_timer_bar:
		answer_timer_bar.stop()
	_cancel_ai_buzz_timer()
	buzzed_player = -1
	attempted_players.clear()

	question_panel.visible = true
	board_grid.visible = false
	_set_header_visible(false)
	_set_board_input_enabled(false)
	if final_wager_panel:
		final_wager_panel.visible = final_round and final_wager_player != -1
	_build_answer_options(clue)
	_begin_question_audio()
	_start_question_flow(question_text)


func _start_question_flow(question_text: String) -> void:
	_type_out_question(question_text)
	_start_tts(question_text)
	_start_answer_timer()


func _type_out_question(text: String) -> void:
	is_typing_question = true
	q_text_label.text = ""
	var length := text.length()
	if length == 0:
		_on_question_typed_out()
		return
	# Iterate characters with a lightweight loop
	for i in range(length):
		q_text_label.text += text[i]
		await get_tree().create_timer(QUESTION_CHAR_DELAY).timeout
	is_typing_question = false
	_on_question_typed_out()


func _start_tts(text: String) -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		DisplayServer.tts_speak(text, "default", TTS_VOLUME, 1.0, 1.0)


func _on_question_typed_out() -> void:
	_start_ai_buzz_timer()


func _build_answer_options(clue: Dictionary) -> void:
	var correct_answer: String = str(clue["answer"])

	var decoys: Array[String] = []
	if clue.has("decoys"):
		for d in clue["decoys"] as Array:
			decoys.append(str(d))
	if decoys.size() > 3:
		decoys.resize(3)

	var options: Array[String] = [correct_answer]
	options.append_array(decoys)
	options.shuffle()  # 4 options total

	current_options.clear()
	for opt in options:
		current_options.append(str(opt))

	_clear_children(answer_buttons)
	answer_button_nodes.clear()
	answer_buttons.visible = false
	answer_buttons.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	answer_buttons.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var center := CenterContainer.new()
	center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	center.anchor_right = 1.0
	center.anchor_bottom = 1.0
	answer_buttons.add_child(center)

	var grid := GridContainer.new()
	grid.columns = 2
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 24)
	grid.add_theme_constant_override("v_separation", 24)
	center.add_child(grid)

	for i in range(options.size()):
		var opt := options[i]
		var btn := Button.new()
		btn.text = opt
		btn.disabled = true
		btn.focus_mode = Control.FOCUS_ALL
		btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		btn.custom_minimum_size = Vector2(320, 160)
		btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		btn.add_theme_font_size_override("font_size", 28)
		_apply_font_override(btn)
		_apply_body_color(btn)
		btn.pressed.connect(func() -> void: _on_answer_selected(opt))

		answer_button_nodes.append(btn)

		grid.add_child(btn)


func _open_answer_buttons_for(player_index: int) -> void:
	answer_buttons.visible = true
	for btn in answer_button_nodes:
		btn.disabled = false
	turn_label.text = "Buzzed: %s" % players[player_index]["name"]


func _on_player_buzz(player_index: int) -> void:
	if current_clue.is_empty():
		return
	if buzzed_player != -1:
		return
	if attempted_players.has(player_index):
		return

	buzzed_player = player_index
	answering_player = player_index
	_set_active_team(player_index)
	_set_question_panel_color(_team_color(player_index))
	var is_ai: bool = players[player_index].get("is_ai", false)

	if final_round:
		# ... your existing final round wager logic ...
		return

	if is_ai:
		_disable_answer_buttons()
		turn_label.text = (
			_t("AI answering: %s", "IA respondendo: %s") % players[player_index].get("name", "AI")
		)
		# Fresh 30s for AI answer
		_start_answer_timer()
		_queue_ai_answer()
		return

	# Human player:
	_open_answer_buttons_for(player_index)

	# Fresh 30s for human answer
	_start_answer_timer()


func _on_answer_selected(answer_text: String) -> void:
	_play_select_sfx()
	if buzzed_player == -1:
		return
	if final_round and not final_wager_set:
		_show_result(_t("Set your wager first.", "Defina sua aposta antes."), Color(0.9, 0.3, 0.3))
		return
	var correct_answer: String = str(current_clue["answer"]).strip_edges().to_lower()
	var given: String = str(answer_text).strip_edges().to_lower()
	var value: int = int(current_clue.get("value", 0))
	if final_round and current_wager > 0:
		value = current_wager
	if given == correct_answer:
		team_scores[buzzed_player] += value
		_set_score_label(buzzed_player)
		_set_active_team(buzzed_player)
		_stop_timers()
		_play_correct_sfx()
		_end_question_audio()
		_show_result(
			(
				_t("Correct! %s +%d", "Correto! %s +%d")
				% [players[buzzed_player].get("name", "Player"), value]
			),
			Color(0.2, 0.7, 0.2)
		)
		turn_label.text = (
			_t("Correct: %s", "Correto: %s") % players[buzzed_player].get("name", "Player")
		)
		_mark_clue_answered()
		question_panel.visible = false
		_set_board_input_enabled(true)
	else:
		attempted_players.append(buzzed_player)
		team_scores[buzzed_player] -= value
		_set_score_label(buzzed_player)
		buzzed_player = -1
		_reset_question_panel_color()
		_play_wrong_sfx()
		if attempted_players.size() >= players.size():
			_handle_all_attempted()
		else:
			_show_result(
				_t("Wrong answer. Others may buzz in.", "Resposta errada. Outros podem tentar."),
				Color(0.8, 0.2, 0.2)
			)
			turn_label.text = _t("Wrong. Waiting for buzz...", "Errado. Aguardando outro buzzer...")
			_update_turn_label_waiting()
			_disable_answer_buttons()
			for i in range(players.size()):
				if players[i].get("is_ai", false) and not attempted_players.has(i):
					_start_ai_buzz_timer(0.75)
					break


func _update_turn_label_waiting() -> void:
	turn_label.text = _t("Waiting for buzz...", "Aguardando buzzer...")


func _disable_answer_buttons() -> void:
	for btn in answer_button_nodes:
		btn.disabled = true
	answer_buttons.visible = false


func _handle_all_attempted() -> void:
	_show_result("", Color(0.1, 0.1, 0.1))
	_end_question_audio()
	_disable_answer_buttons()
	_mark_clue_answered()
	turn_label.text = ""
	if question_panel:
		question_panel.visible = false
	_set_board_input_enabled(true)


func _is_answer_timer_active() -> bool:
	return (
		answer_timer_bar != null
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("is_running")
		and answer_timer_bar.is_running()
	)


func _start_answer_timer() -> void:
	if (
		answer_timer_bar
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("restart")
	):
		answer_timer_bar.restart(ANSWER_TIME)  # full 30s, from scratch


func _on_answer_timer_timeout() -> void:
	if (
		answer_timer_bar
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("stop")
	):
		answer_timer_bar.stop()
	# Time up, nobody got it right
	_show_result(_t("Time's up!", "Tempo esgotado!"), Color(0.8, 0.4, 0.0))
	_end_question_audio()
	_mark_clue_answered()
	turn_label.text = _t("Time's up. Choose another clue.", "Tempo esgotado. Escolha outra pista.")
	question_panel.visible = false
	_disable_answer_buttons()
	_set_board_input_enabled(true)


func _mark_clue_answered() -> void:
	var cat_index: int = current_clue.get("cat_index", -1)
	var clue_index: int = current_clue.get("clue_index", -1)
	var button: Button = current_clue.get("button", null)

	if cat_index == -1 or clue_index == -1:
		current_clue.clear()
		return

	var key := "%d-%d" % [cat_index, clue_index]
	answered_map[key] = true

	if button:
		button.disabled = true
		button.text = ""

	buzzed_player = -1
	attempted_players.clear()
	current_options.clear()
	_stop_timers()
	_reset_question_panel_color()
	answering_player = -1
	current_clue.clear()
	if final_round:
		board_grid.visible = false
		turn_label.text = _t("Final scores", "Pontuacao final")
		if final_wager_panel:
			final_wager_panel.visible = false
		if final_clue_button:
			final_clue_button.disabled = false
		final_wager_set = false
	else:
		board_grid.visible = true
		_set_header_visible(true)
		turn_label.text = ""
		_advance_round_if_needed()


func _restart_to_main_menu() -> void:
	_end_question_audio()
	_stop_timers()
	settings_opened_from_pause = false
	current_clue.clear()
	current_options.clear()
	current_categories.clear()
	answered_map.clear()
	attempted_players.clear()
	buzzed_player = -1
	final_round = false
	hidden_double_key = ""
	current_wager = 0
	players.clear()
	team_names.clear()
	team_scores.clear()
	team_score_labels.clear()
	team_cards.clear()
	_clear_children(scoreboard)
	_clear_children(board_grid)
	board_grid.columns = 1
	result_label.text = ""
	q_text_label.text = ""
	q_category_label.text = ""
	q_value_label.text = ""
	turn_label.text = ""
	question_panel.visible = false
	game_root.visible = false
	_close_pause_menu()
	_populate_player_count()
	_reset_round_state()
	_show_title()
	_play_background_music()


func _on_exit_pressed() -> void:
	_save_settings()
	get_tree().quit()


func _stop_timers(preserve_result: bool = false) -> void:
	if (
		answer_timer_bar
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("stop")
	):
		answer_timer_bar.stop()
	_cancel_ai_buzz_timer()

	if not preserve_result:
		result_label.add_theme_color_override("font_color", Color(0.1, 0.1, 0.1))
		result_label.text = ""


func _set_board_input_enabled(enabled: bool) -> void:
	if board_grid == null or not is_instance_valid(board_grid):
		return
	for child in board_grid.get_children():
		if child is Button:
			var btn := child as Button
			if not btn.has_meta("cat_index") or not btn.has_meta("clue_index"):
				continue
			var cat_index: int = btn.get_meta("cat_index")
			var clue_index: int = btn.get_meta("clue_index")
			var key := "%d-%d" % [cat_index, clue_index]
			if answered_map.has(key):
				btn.disabled = true
				btn.text = ""
			else:
				btn.disabled = not enabled
	board_grid.visible = enabled


func _show_result(text: String, color: Color = Color(0.1, 0.1, 0.1)) -> void:
	result_label.text = text
	result_label.add_theme_color_override("font_color", color)


func _reset_round_state() -> void:
	round_index = 0
	final_round = false
	current_wager = 0
	final_wager_player = -1
	final_wager_set = false
	final_clue_used = false
	hidden_double_key = ""
	current_categories.clear()
	current_options.clear()
	total_clues_this_round = 0
	category_deck = LoadedBibleData.get_categories()
	answered_map.clear()
	current_turn_team = 0
	answering_player = -1
	if final_wager_panel:
		final_wager_panel.visible = false
	if final_clue_button:
		final_clue_button.disabled = false
	if final_wager_input:
		final_wager_input.text = ""
	_reset_question_panel_color()


func _select_hidden_double(num_categories: int, num_clues: int) -> void:
	if num_categories <= 0:
		hidden_double_key = ""
		return
	var cat_index: int = rng.randi_range(0, num_categories - 1)
	var clue_index: int = rng.randi_range(0, max(0, num_clues - 1))
	hidden_double_key = "%d-%d" % [cat_index, clue_index]


func _advance_round_if_needed() -> void:
	if final_round:
		return
	if total_clues_this_round == 0:
		return
	if answered_map.size() >= total_clues_this_round:
		round_index += 1
		hidden_double_key = ""
		answered_map.clear()
		if round_index >= ROUND_VALUES.size():
			_start_final_round()
		else:
			_show_result(_t("Round %d!", "Rodada %d!") % (round_index + 1), Color(0.6, 0.8, 1.0))
			_build_board()


func _start_final_round() -> void:
	final_round = true
	current_wager = 0
	current_options.clear()
	total_clues_this_round = 0
	answered_map.clear()
	final_wager_player = -1
	final_wager_set = false
	final_clue_used = false
	_stop_timers()
	_end_question_audio()
	_clear_children(board_grid)
	board_grid.visible = false
	_set_header_visible(true)

	if category_deck.is_empty():
		category_deck = LoadedBibleData.get_categories()
	var take: int = min(3, category_deck.size())
	var categories: Array = []
	for i in range(take):
		categories.append(category_deck.pop_back())
	current_categories = categories.duplicate(true)
	if current_categories.is_empty():
		return
	var cat_index: int = rng.randi_range(0, current_categories.size() - 1)
	var cat_data: Dictionary = current_categories[cat_index] as Dictionary
	var values: Array = cat_data["values"] as Array
	var hardest_index: int = min(2, values.size() - 1)
	var pool: Array = (values[hardest_index] as Dictionary)["pool"] as Array
	if pool.is_empty():
		return

	var clue: Dictionary = pool[rng.randi_range(0, pool.size() - 1)] as Dictionary
	var question_text := str(clue["question"])
	var score_value: int = (values[hardest_index] as Dictionary).get("value", 0)

	current_clue = {
		"cat_index": cat_index,
		"clue_index": hardest_index,
		"value": score_value,
		"button": null,
		"answer": clue["answer"],
		"is_double": false
	}

	q_category_label.text = _t("Final Round: %s", "Rodada final: %s") % str(cat_data["name"])
	q_value_label.text = _t("Wager your points!", "Aposte seus pontos!")
	q_text_label.text = ""
	result_label.text = _t(
		"Final round! Buzz to set your wager.", "Rodada final! Aperte para definir sua aposta."
	)
	if final_wager_panel:
		final_wager_panel.visible = false
	if final_clue_button:
		final_clue_button.disabled = false
	question_panel.visible = true
	game_root.visible = true
	_build_answer_options(clue)
	_begin_question_audio()
	_start_question_flow(question_text)


func _set_header_visible(visible: bool) -> void:
	title_label.visible = visible
	scoreboard.visible = true
	turn_label.visible = visible


func _unhandled_input(event: InputEvent) -> void:
	if pause_menu.visible:
		return
	if current_clue.is_empty():
		return
	if buzzed_player != -1:
		return
	if not _is_answer_timer_active() and is_typing_question == false and ai_buzz_timer == null:
		# In case typing ended without timer; ensure AI timer exists
		_on_question_typed_out()

	var player_index := _player_from_event(event)
	if player_index != -1:
		_on_player_buzz(player_index)


func _player_from_event(event: InputEvent) -> int:
	if event.is_echo():
		return -1
	if event is InputEventKey and event.pressed:
		var key_event := event as InputEventKey
		if key_event.keycode == KEY_SPACE:
			# Keyboard is always players[0] if present and human
			if players.size() > 0 and players[0]["uses_keyboard"] and not players[0]["is_ai"]:
				return 0
	if event is InputEventJoypadButton and event.pressed:
		var joy_event := event as InputEventJoypadButton
		for i in range(players.size()):
			var p: Dictionary = players[i] as Dictionary
			if p["is_ai"]:
				continue
			if p["uses_keyboard"]:
				continue
			if p["device_id"] == joy_event.device:
				return i
	return -1


func _on_ai_try_buzz() -> void:
	if current_clue.is_empty():
		return
	if buzzed_player != -1:
		return
	# Pick first AI that hasn't tried yet
	for i in range(players.size()):
		var p: Dictionary = players[i] as Dictionary
		if not p["is_ai"]:
			continue
		if attempted_players.has(i):
			continue
		_on_player_buzz(i)
		break


func _flip_card(button: Button) -> void:
	if button == null:
		return
	var tween := create_tween()
	(
		tween
		. tween_property(button, "scale", Vector2(0.0, 1.0), 0.2)
		. set_trans(Tween.TRANS_SINE)
		. set_ease(Tween.EASE_IN)
	)
	(
		tween
		. tween_property(button, "scale", Vector2(1.0, 1.0), 0.2)
		. set_trans(Tween.TRANS_SINE)
		. set_ease(Tween.EASE_OUT)
	)
	await tween.finished


func _start_ai_buzz_timer(delay: float = AI_BUZZ_DELAY) -> void:
	_cancel_ai_buzz_timer()
	if delay < 0.0:
		delay = 0.0
	ai_buzz_timer = get_tree().create_timer(delay)
	ai_buzz_timer.timeout.connect(_on_ai_try_buzz)


func _cancel_ai_buzz_timer() -> void:
	if ai_buzz_timer:
		if ai_buzz_timer.timeout.is_connected(_on_ai_try_buzz):
			ai_buzz_timer.timeout.disconnect(_on_ai_try_buzz)
		ai_buzz_timer = null


func _trigger_ai_after_wrong() -> void:
	_cancel_ai_buzz_timer()
	_on_ai_try_buzz()


func _queue_ai_answer() -> void:
	if buzzed_player == -1:
		return
	if _buzzer_is_human():
		return
	get_tree().create_timer(0.6).timeout.connect(func() -> void: _ai_answer_current())


func _buzzer_is_human() -> bool:
	if buzzed_player < 0 or buzzed_player >= players.size():
		return true
	return not players[buzzed_player].get("is_ai", false)


func _ai_answer_current() -> void:
	if buzzed_player == -1:
		return
	if current_clue.is_empty():
		return
	if current_options.is_empty():
		return

	var correct_raw := str(current_clue.get("answer", ""))
	var correct_norm := correct_raw.strip_edges().to_lower()

	var wrong_choices: Array[String] = []
	for opt in current_options:
		var opt_norm := str(opt).strip_edges().to_lower()
		if opt_norm != correct_norm:
			wrong_choices.append(str(opt))

	var pick_correct := rng.randf() < 0.7
	var choice := correct_raw
	if not pick_correct and not wrong_choices.is_empty():
		choice = wrong_choices[rng.randi_range(0, wrong_choices.size() - 1)]

	_on_answer_selected(choice)


func _t(en_text: String, pt_text: String) -> String:
	return pt_text if current_language == "pt" else en_text


func _handle_escape_input(event: InputEvent) -> bool:
	if pause_menu == null:
		return false
	var esc_pressed := event.is_action_pressed("ui_cancel")
	if not esc_pressed and event is InputEventKey:
		var key_event := event as InputEventKey
		esc_pressed = key_event.pressed and not key_event.echo and key_event.keycode == KEY_ESCAPE
	if esc_pressed:
		if settings_panel.visible and settings_opened_from_pause:
			_play_select_sfx()
			settings_opened_from_pause = false
			settings_panel.visible = false
			_open_pause_menu()
		elif pause_menu.visible:
			_play_select_sfx()
			_close_pause_menu()
		elif _can_open_pause_menu():
			_play_select_sfx()
			_open_pause_menu()
		get_viewport().set_input_as_handled()
		return true
	return false
