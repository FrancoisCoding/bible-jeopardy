extends Control

@export var game_font: Font = preload("res://fonts/Comic Sans MS.ttf")
@export var title_texture: Texture2D = preload("res://game title.png")
@export var bible_character_textures: Array[Texture2D] = []

const LoadedBibleData = preload("res://src/data/bible_data.gd")
const VerseData = preload("res://src/data/verse_data.gd")
const FinalJeopardyData = preload("res://src/data/final_jeopardy_data.gd")
const ThemeStyler = preload("res://src/ui/main/theme_styler.gd")
const AudioController = preload("res://src/ui/main/audio_controller.gd")
const MainMenuScreen = preload("res://src/ui/screens/main_menu_screen.gd")
const BoardScreen = preload("res://src/ui/screens/board_screen.gd")
const SettingsScreen = preload("res://src/ui/screens/settings_screen.gd")
const MUSIC_BACKGROUND := preload("res://music/background music.mp3")
const MUSIC_QUESTION := preload("res://music/question music.mp3")
const SFX_CORRECT := preload("res://music/correct.mp3")
const SFX_WRONG := preload("res://music/wrong answer.mp3")
const SFX_SELECT := preload("res://music/select_001.ogg")
const TTS_VOLUME := 80.0
const TEAM_COLORS := [Color(0.9, 0.2, 0.2), Color(0.2, 0.45, 0.95), Color(0.15, 0.75, 0.35)]  # Red  # Blue  # Green

const QUESTION_CHAR_DELAY := 0.03
const AI_BUZZ_DELAY := 5.0
const AI_BOARD_PICK_DELAY := 5.0
const ANSWER_TIME := 30.0
const FINAL_WAGER_TIME := 30.0
const AI_DIFFICULTY_RATES := {"easy": 0.2, "normal": 0.4, "hard": 0.7}
const ROUND_VALUES := [[400, 800, 1200], [800, 1200, 2000]]
const ROUND_CLUE_COUNT := 3
const CHARACTER_ROSTER := [
	{"name": "John", "bg": Color(0.95, 0.57, 0.18), "accent": Color(0.2, 0.42, 0.78)},
	{"name": "Peter", "bg": Color(0.16, 0.69, 0.65), "accent": Color(0.09, 0.47, 0.42)},
	{"name": "Paul", "bg": Color(0.2, 0.65, 0.22), "accent": Color(0.86, 0.32, 0.32)},
	{"name": "Mary", "bg": Color(0.78, 0.42, 0.62), "accent": Color(0.22, 0.43, 0.25)},
	{"name": "Ruth", "bg": Color(0.74, 0.25, 0.59), "accent": Color(0.51, 0.44, 0.18)},
	{"name": "Abraham", "bg": Color(0.36, 0.64, 0.9), "accent": Color(0.24, 0.47, 0.72)},
	{"name": "Moses", "bg": Color(0.18, 0.56, 0.2), "accent": Color(0.82, 0.65, 0.33)},
	{"name": "Deborah", "bg": Color(0.86, 0.64, 0.44), "accent": Color(0.35, 0.31, 0.56)},
	{"name": "John the Baptist", "bg": Color(0.26, 0.52, 0.23), "accent": Color(0.8, 0.36, 0.19)},
	{"name": "Solomon", "bg": Color(0.53, 0.49, 0.76), "accent": Color(0.3, 0.25, 0.54)},
	{"name": "David", "bg": Color(0.19, 0.46, 0.85), "accent": Color(0.9, 0.55, 0.24)},
	{"name": "Noah", "bg": Color(0.92, 0.52, 0.2), "accent": Color(0.15, 0.38, 0.71)}
]
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
@onready var controller_connect_panel: Control = get_node_or_null("ControllerConnectPanel")
@onready var controller_title_label: Label = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/ConnectTitle"
)
@onready var controller_subtitle_label: Label = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/ConnectSubtitle"
)
@onready var controller_slot_labels: Array[Label] = [
	get_node_or_null("ControllerConnectPanel/Content/VBox/Slots/Slot1/Label"),
	get_node_or_null("ControllerConnectPanel/Content/VBox/Slots/Slot2/Label"),
	get_node_or_null("ControllerConnectPanel/Content/VBox/Slots/Slot3/Label")
]
@onready var controller_slot_panels: Array[PanelContainer] = [
	get_node_or_null("ControllerConnectPanel/Content/VBox/Slots/Slot1"),
	get_node_or_null("ControllerConnectPanel/Content/VBox/Slots/Slot2"),
	get_node_or_null("ControllerConnectPanel/Content/VBox/Slots/Slot3")
]
@onready var controller_status_label: Label = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/StatusLabel"
)
@onready var controller_ai_label: Label = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/AIDifficultyLabel"
)
@onready var controller_ai_option: OptionButton = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/AIDifficultyOption"
)
@onready var controller_start_button: Button = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/ButtonRow/StartButton"
)
@onready var controller_cancel_button: Button = get_node_or_null(
	"ControllerConnectPanel/Content/VBox/ButtonRow/CancelButton"
)
@onready
var controller_connect_content: PanelContainer = get_node_or_null("ControllerConnectPanel/Content")
@onready var character_select_panel: Control = get_node_or_null("CharacterSelectPanel")
@onready var character_select_title_label: Label = get_node_or_null(
	"CharacterSelectPanel/Content/VBox/SelectTitle"
)
@onready var character_select_subtitle_label: Label = get_node_or_null(
	"CharacterSelectPanel/Content/VBox/SelectSubtitle"
)
@onready
var character_select_content: PanelContainer = get_node_or_null("CharacterSelectPanel/Content")
@onready
var character_prompt_label: Label = get_node_or_null("CharacterSelectPanel/Content/VBox/Prompt")
@onready var character_option_grid: GridContainer = get_node_or_null(
	"CharacterSelectPanel/Content/VBox/Options"
)
@onready var character_back_button: Button = get_node_or_null(
	"CharacterSelectPanel/Content/VBox/CharacterButtonRow/CharacterBackButton"
)
@onready var character_slot_panels: Array[PanelContainer] = [
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot1"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot2"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot3")
]
@onready var character_slot_portraits: Array[ColorRect] = [
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot1/SlotVBox/Portrait"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot2/SlotVBox/Portrait"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot3/SlotVBox/Portrait")
]
@onready var character_slot_labels: Array[Label] = [
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot1/SlotVBox/SlotLabel"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot2/SlotVBox/SlotLabel"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot3/SlotVBox/SlotLabel")
]
@onready var character_slot_hints: Array[Label] = [
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot1/SlotVBox/SlotHint"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot2/SlotVBox/SlotHint"),
	get_node_or_null("CharacterSelectPanel/Content/VBox/Slots/Slot3/SlotVBox/SlotHint")
]
@onready var online_panel: Control = get_node_or_null("OnlinePanel")
@onready var title_online_button: Button = get_node_or_null("TitlePanel/VBox/OnlineButton")
@onready
var online_title_label: Label = get_node_or_null("OnlinePanel/OnlineContent/VBox/OnlineTitle")
@onready var online_host_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/ActionRow/HostButton"
)
@onready var online_join_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/ActionRow/JoinButton"
)
@onready var online_back_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/ActionRow/OnlineBackButton"
)
@onready
var online_host_lobby: PanelContainer = get_node_or_null("OnlinePanel/OnlineContent/VBox/HostLobby")
@onready
var online_join_panel: PanelContainer = get_node_or_null("OnlinePanel/OnlineContent/VBox/JoinPanel")
@onready var online_code_label: Label = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/CodeLabel"
)
@onready var online_code_value: Label = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/CodeValue"
)
@onready var online_slot_labels: Array[Label] = [
	get_node_or_null("OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/PlayerList/Slot1"),
	get_node_or_null("OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/PlayerList/Slot2"),
	get_node_or_null("OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/PlayerList/Slot3")
]
@onready var online_status_label: Label = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/HostStatus"
)
@onready var online_host_start_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/HostButtons/HostStartButton"
)
@onready var online_host_leave_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/HostLobby/HostVBox/HostButtons/HostLeaveButton"
)
@onready var online_join_code_input: LineEdit = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/JoinPanel/JoinVBox/JoinCodeInput"
)
@onready var online_join_ip_input: LineEdit = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/JoinPanel/JoinVBox/JoinIPInput"
)
@onready var online_join_status: Label = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/JoinPanel/JoinVBox/JoinStatus"
)
@onready var online_join_connect_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/JoinPanel/JoinVBox/JoinButtons/JoinConnectButton"
)
@onready var online_join_cancel_button: Button = get_node_or_null(
	"OnlinePanel/OnlineContent/VBox/JoinPanel/JoinVBox/JoinButtons/JoinCancelButton"
)

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
@onready var answer_timer_bar = get_node_or_null("QuestionPanel/QuestionVBox/TimerBar")
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
var team_trophies: Array[Label] = []
var team_wager_labels: Array[Label] = []
var team_card_pulse_tween: Tween = null

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
var join_inputs: Array[Dictionary] = []  # Ordered join list of controllers/keyboard
var pending_player_inputs: Array[Dictionary] = []
var selected_player_characters: Array[Dictionary] = []
var character_selection_index: int = 0
var character_human_count: int = 0
var character_option_buttons: Array[Button] = []
var player_characters: Array[Dictionary] = []
var controller_join_active: bool = false
var answering_input_lock: Dictionary = {}
var nav_focus_enabled: bool = false  # Only grab focus highlights when a controller/keyboard joins
var settings_opened_from_pause: bool = false
var ai_difficulty: String = "normal"
var ai_correct_rate: float = AI_DIFFICULTY_RATES["normal"]
var online_peer: ENetMultiplayerPeer
var online_is_host: bool = false
var online_room_code: String = ""
var online_host_peer_id: int = -1
var online_players: Array[Dictionary] = []  # [{id,name}]
const ONLINE_MAX_PLAYERS := 3
const ONLINE_MIN_PLAYERS := 2
var online_active: bool = false
var local_player_index: int = -1
var round_index: int = 0
var final_round: bool = false
var hidden_double_key: String = ""
var total_clues_this_round: int = 0
var current_wager: int = 0
var final_wager_player: int = -1
var final_wager_set: bool = false
var final_clue_used: bool = false
var final_question: Dictionary = {}
var final_question_revealed: bool = false
var final_wager_values: Array[int] = []
var final_wager_done: Array[bool] = []
var final_answer_choices: Array[String] = []
var final_answered: Array[bool] = []
var final_wager_timer: SceneTreeTimer
var final_answer_index: int = 0
var current_turn_team: int = 0
var answering_player: int = -1
var background_rect: TextureRect
var theme_body_color: Color = Color(0.05, 0.08, 0.2)
var category_deck: Array = []
var loading_settings: bool = false
var verse_data := VerseData.new()
var question_panel_base_style: StyleBox = null
var theme_styler: ThemeStyler
var audio_controller: AudioController
var main_menu_screen: MainMenuScreen
var board_screen: BoardScreen
var settings_screen: SettingsScreen
const SETTINGS_PATH := "user://settings.cfg"


func _ready() -> void:
	theme_styler = ThemeStyler.new(theme_body_color, TEAM_COLORS)
	audio_controller = AudioController.new(
		self,
		music_player,
		question_music_player,
		sfx_correct_player,
		sfx_wrong_player,
		sfx_select_player,
		music_slider
	)
	main_menu_screen = MainMenuScreen.new(
		title_panel,
		settings_panel,
		player_select_panel,
		verse_panel,
		verse_title_label,
		verse_text_label,
		verse_reference_label,
		title_play_button,
		title_settings_button,
		settings_language_label,
		music_label,
		settings_back_button,
		settings_exit_button,
		player_select_title,
		player_count_option,
		player_info_label,
		player_start_button,
		pause_title_label,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		language_option,
		music_slider,
		answer_timer_label,
		final_wager_label,
		final_wager_input,
		final_wager_button,
		final_clue_button,
		game_root,
		question_panel,
		verse_data,
		func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
	)
	board_screen = BoardScreen.new(theme_styler, game_font)
	settings_screen = SettingsScreen.new(
		title_panel, settings_panel, player_select_panel, pause_menu, game_root, question_panel
	)

	_update_verse_of_day()
	# Hook up UI
	title_play_button.pressed.connect(_on_play_pressed)
	if title_online_button:
		title_online_button.pressed.connect(_on_online_pressed)
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
	if controller_start_button:
		controller_start_button.pressed.connect(_on_controller_connect_confirm_pressed)
	if controller_cancel_button:
		controller_cancel_button.pressed.connect(_on_controller_connect_cancel_pressed)
	if controller_ai_option:
		controller_ai_option.item_selected.connect(
			func(idx: int) -> void: _on_ai_difficulty_selected(idx)
		)
	if character_back_button:
		character_back_button.pressed.connect(_on_character_back_pressed)
	if online_host_button:
		online_host_button.pressed.connect(_on_online_host_pressed)
	if online_join_button:
		online_join_button.pressed.connect(_on_online_join_pressed)
	if online_back_button:
		online_back_button.pressed.connect(_on_online_back_pressed)
	if online_host_start_button:
		online_host_start_button.pressed.connect(_on_online_host_pressed)
	if online_host_leave_button:
		online_host_leave_button.pressed.connect(_on_online_back_pressed)
	if online_join_connect_button:
		online_join_connect_button.pressed.connect(_on_online_join_pressed)
	if online_join_cancel_button:
		online_join_cancel_button.pressed.connect(_on_online_back_pressed)
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
	_ensure_default_input_actions()
	_setup_pause_menu_focus()
	set_process_input(true)
	_populate_player_count()
	_show_title()
	audio_controller.configure_streams(
		MUSIC_BACKGROUND, MUSIC_QUESTION, SFX_CORRECT, SFX_WRONG, SFX_SELECT
	)
	audio_controller.sync_slider_from_bus()
	audio_controller.play_background_music()
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
	_apply_theme_styles()
	_reset_round_state()


func _get_today_key() -> String:
	var d = Time.get_date_dict_from_system()
	# Example: "2025-11-21"
	return "%04d-%02d-%02d" % [d.year, d.month, d.day]


func _get_verse_for_today() -> Dictionary:
	var key := _get_today_key()
	return verse_data.get_for_key(key, current_language)


func _update_verse_of_day():
	if main_menu_screen:
		main_menu_screen.update_verse_of_day(current_language, _get_today_key())


func _populate_player_count() -> void:
	player_count_option.clear()
	for i in range(2, 4):
		player_count_option.add_item("%d Players" % i, i)
	player_count_option.selected = 0
	_reset_round_state()
	_apply_resolution(Vector2i(1920, 1080))


func _apply_language_texts() -> void:
	LoadedBibleData.set_language(current_language)
	FinalJeopardyData.set_language(current_language)
	if main_menu_screen:
		main_menu_screen.apply_language_texts(
			current_language, func(lang: String) -> void: LoadedBibleData.set_language(lang)
		)
	_update_player_info_label()
	_apply_controller_connect_text()
	_apply_character_select_text()
	_apply_online_texts()

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
	if main_menu_screen:
		main_menu_screen.setup_accessible_text()


func _apply_controller_connect_text() -> void:
	if controller_title_label:
		controller_title_label.text = _t("Connect Controllers", "Conecte os controles")
	if controller_subtitle_label:
		controller_subtitle_label.text = _t(
			"Press any button to claim Players 1-3. Remaining slots become AI.",
			"Aperte qualquer botao para assumir os Jogadores 1-3. Vagas restantes viram IA."
		)
	if controller_ai_label:
		controller_ai_label.text = _t("AI Difficulty", "Dificuldade da IA")
	if controller_ai_option:
		controller_ai_option.clear()
		controller_ai_option.add_item(_t("Easy (20%)", "Facil (20%)"), 0)
		controller_ai_option.add_item(_t("Normal (40%)", "Normal (40%)"), 1)
		controller_ai_option.add_item(_t("Hard (70%)", "Dificil (70%)"), 2)
		controller_ai_option.select(1)
	if controller_start_button:
		controller_start_button.text = _t("Continue", "Continuar")
	if controller_cancel_button:
		controller_cancel_button.text = _t("Back", "Voltar")
	_refresh_controller_join_ui()


func _apply_character_select_text() -> void:
	if character_select_title_label:
		character_select_title_label.text = _t("Choose Your Character", "Escolha seu personagem")
	if character_select_subtitle_label:
		character_select_subtitle_label.text = _t(
			"Each player picks a unique hero. AI players are randomized.",
			"Cada jogador escolhe um heroi unico. IAs sao aleatorias."
		)
	if character_back_button:
		character_back_button.text = _t("Back", "Voltar")
	_update_character_prompt()


func _apply_online_texts() -> void:
	if title_online_button:
		title_online_button.text = _t("Online", "Online")
	if online_title_label:
		online_title_label.text = _t("Online Multiplayer", "Multijogador Online")
	if online_host_button:
		online_host_button.text = _t("Host Room", "Hospedar Sala")
	if online_join_button:
		online_join_button.text = _t("Join Room", "Entrar na Sala")
	if online_back_button:
		online_back_button.text = _t("Back", "Voltar")
	if online_code_label:
		online_code_label.text = _t("Room Code", "Codigo da sala")
	if online_status_label:
		online_status_label.text = _t("Waiting for players...", "Aguardando jogadores...")
	if online_host_start_button:
		online_host_start_button.text = _t("Start Game", "Iniciar jogo")
	if online_host_leave_button:
		online_host_leave_button.text = _t("Leave Room", "Sair da sala")
	if online_join_code_input:
		online_join_code_input.placeholder_text = _t("Enter room code", "Digite o codigo")
	if online_join_ip_input:
		online_join_ip_input.placeholder_text = "127.0.0.1"
	if online_join_status:
		online_join_status.text = ""
	if online_join_connect_button:
		online_join_connect_button.text = _t("Join", "Entrar")
	if online_join_cancel_button:
		online_join_cancel_button.text = _t("Cancel", "Cancelar")
	_update_online_panel_visibility(false, false)
	_update_online_status("", false)


func _update_online_panel_visibility(show_host: bool, show_join: bool) -> void:
	if online_host_lobby:
		online_host_lobby.visible = show_host
	if online_join_panel:
		online_join_panel.visible = show_join


func _update_online_status(text: String, is_error: bool = false) -> void:
	if online_status_label:
		online_status_label.text = text
		online_status_label.add_theme_color_override(
			"font_color", Color(0.8, 0.2, 0.2) if is_error else Color(0.1, 0.1, 0.1)
		)
	if online_join_status:
		online_join_status.text = text
		online_join_status.add_theme_color_override(
			"font_color", Color(0.8, 0.2, 0.2) if is_error else Color(0.1, 0.1, 0.1)
		)


func _shutdown_online_session() -> void:
	if online_peer:
		online_peer.close()
	online_peer = null
	online_is_host = false
	online_active = false
	online_room_code = ""
	online_host_peer_id = -1
	local_player_index = -1
	online_players.clear()
	_update_online_panel_visibility(false, false)
	_update_online_status("", false)
	_refresh_controller_join_ui()


func _apply_theme_styles() -> void:
	if theme_styler == null:
		return

	var font_controls: Array[Control] = [
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
		final_wager_input,
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
		final_clue_button,
		controller_title_label,
		controller_subtitle_label,
		controller_status_label,
		controller_slot_labels[0] if controller_slot_labels.size() > 0 else null,
		controller_slot_labels[1] if controller_slot_labels.size() > 1 else null,
		controller_slot_labels[2] if controller_slot_labels.size() > 2 else null
	]
	theme_styler.apply_game_font(game_font, font_controls)

	background_rect = theme_styler.setup_background(self, background_rect)

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
		answer_timer_label,
		controller_title_label,
		controller_subtitle_label,
		controller_status_label,
		controller_slot_labels[0] if controller_slot_labels.size() > 0 else null,
		controller_slot_labels[1] if controller_slot_labels.size() > 1 else null,
		controller_slot_labels[2] if controller_slot_labels.size() > 2 else null,
		controller_ai_label,
		controller_ai_option,
		controller_start_button,
		controller_cancel_button,
		character_select_title_label,
		character_select_subtitle_label,
		character_prompt_label,
		character_slot_labels[0] if character_slot_labels.size() > 0 else null,
		character_slot_labels[1] if character_slot_labels.size() > 1 else null,
		character_slot_labels[2] if character_slot_labels.size() > 2 else null,
		character_slot_hints[0] if character_slot_hints.size() > 0 else null,
		character_slot_hints[1] if character_slot_hints.size() > 1 else null,
		character_slot_hints[2] if character_slot_hints.size() > 2 else null,
		online_title_label,
		online_code_label,
		online_code_value,
		online_status_label,
		online_slot_labels[0] if online_slot_labels.size() > 0 else null,
		online_slot_labels[1] if online_slot_labels.size() > 1 else null,
		online_slot_labels[2] if online_slot_labels.size() > 2 else null,
		online_join_status,
		online_join_code_input,
		online_join_ip_input
	]

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
		final_clue_button,
		controller_start_button,
		controller_cancel_button,
		character_back_button,
		online_host_button,
		online_join_button,
		online_back_button,
		online_host_start_button,
		online_host_leave_button,
		online_join_connect_button,
		online_join_cancel_button
	]

	var pause_panel := (
		pause_menu.get_node("Panel") if pause_menu and pause_menu.has_node("Panel") else null
	)
	question_panel_base_style = theme_styler.apply_bible_theme(
		title_screen_title,
		title_label,
		primary_controls,
		settings_language_label,
		music_label,
		answer_timer_label,
		question_panel,
		pause_panel,
		button_controls,
		game_font,
		answer_timer_bar,
		ANSWER_TIME
	)

	if controller_connect_content and question_panel_base_style:
		controller_connect_content.add_theme_stylebox_override(
			"panel", question_panel_base_style.duplicate()
		)
	if character_select_content and question_panel_base_style:
		character_select_content.add_theme_stylebox_override(
			"panel", question_panel_base_style.duplicate()
		)
	_refresh_controller_join_ui()


func _stop_team_card_pulse() -> void:
	if team_card_pulse_tween and is_instance_valid(team_card_pulse_tween):
		if team_card_pulse_tween.is_running():
			team_card_pulse_tween.stop()
		team_card_pulse_tween.kill()
	team_card_pulse_tween = null
	for c in team_cards:
		if c and is_instance_valid(c):
			(c as Control).scale = Vector2.ONE


func _start_team_card_pulse(idx: int) -> void:
	_stop_team_card_pulse()
	if idx < 0 or idx >= team_cards.size():
		return
	var card := team_cards[idx]
	if card == null or not is_instance_valid(card):
		return
	if theme_styler == null:
		return
	var color := theme_styler.team_color(idx)
	theme_styler.apply_team_card_style(card, color, true)
	card.scale = Vector2.ONE
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()  # Continuous pulse
	tween.tween_property(card, "scale", Vector2.ONE * 1.04, 0.45)
	tween.tween_property(card, "scale", Vector2.ONE, 0.45)
	team_card_pulse_tween = tween


func _set_active_team(idx: int) -> void:
	if idx < 0 or idx >= team_cards.size():
		current_turn_team = clamp(idx, 0, max(0, team_cards.size() - 1))
	else:
		current_turn_team = idx
	if theme_styler:
		theme_styler.refresh_team_highlight(team_cards, current_turn_team)
		_start_team_card_pulse(current_turn_team)


func _set_question_panel_color(color: Color) -> void:
	if theme_styler and question_panel_base_style:
		theme_styler.set_question_panel_color(question_panel, question_panel_base_style, color)


func _reset_question_panel_color() -> void:
	if theme_styler and question_panel_base_style:
		theme_styler.reset_question_panel_color(question_panel, question_panel_base_style)


func _play_background_music() -> void:
	if audio_controller:
		audio_controller.play_background_music()


func _begin_question_audio() -> void:
	if audio_controller:
		audio_controller.begin_question_audio()


func _end_question_audio() -> void:
	if audio_controller:
		audio_controller.end_question_audio()


func _play_correct_sfx() -> void:
	if audio_controller:
		audio_controller.play_correct_sfx()


func _play_wrong_sfx() -> void:
	if audio_controller:
		audio_controller.play_wrong_sfx()


func _play_select_sfx() -> void:
	if audio_controller:
		audio_controller.play_select_sfx()


func _show_title() -> void:
	_shutdown_online_session()
	if main_menu_screen:
		main_menu_screen.show_title()
	if controller_connect_panel:
		controller_connect_panel.visible = false
	if character_select_panel:
		character_select_panel.visible = false
	if online_panel:
		online_panel.visible = false
	pending_player_inputs.clear()
	selected_player_characters.clear()
	player_characters.clear()
	character_selection_index = 0
	character_human_count = 0
	controller_join_active = false
	online_active = false
	local_player_index = -1
	_close_pause_menu()
	if title_play_button and nav_focus_enabled:
		title_play_button.grab_focus()


func _on_play_pressed() -> void:
	_play_select_sfx()
	_open_controller_connect()


func _on_settings_pressed() -> void:
	_play_select_sfx()
	settings_opened_from_pause = false
	if settings_screen:
		settings_screen.show_settings_from_title()
	if language_option and nav_focus_enabled:
		language_option.grab_focus()


func _on_settings_back_pressed() -> void:
	_play_select_sfx()
	if settings_opened_from_pause:
		settings_opened_from_pause = false
		if settings_screen:
			settings_screen.back_to_pause()
	else:
		_show_title()


func _on_online_pressed() -> void:
	_play_select_sfx()
	_show_online_menu()


func _on_online_host_pressed() -> void:
	_play_select_sfx()
	_update_online_status(
		_t("Online play is disabled in this build.", "Online desativado nesta versao."), true
	)


func _on_online_join_pressed() -> void:
	_play_select_sfx()
	_update_online_status(
		_t("Online play is disabled in this build.", "Online desativado nesta versao."), true
	)


func _on_online_back_pressed() -> void:
	_play_select_sfx()
	_show_title()


func _show_online_menu() -> void:
	title_panel.visible = false
	settings_panel.visible = false
	player_select_panel.visible = false
	_close_pause_menu()
	if controller_connect_panel:
		controller_connect_panel.visible = false
	if online_panel:
		online_panel.visible = true
	_update_online_panel_visibility(true, false)
	_update_online_status(
		_t("Online play is disabled in this build.", "Online desativado nesta versao."), true
	)
	if nav_focus_enabled and online_back_button:
		online_back_button.grab_focus()


func _open_controller_connect() -> void:
	title_panel.visible = false
	settings_panel.visible = false
	player_select_panel.visible = false
	controller_join_active = true
	join_inputs.clear()
	if controller_connect_panel == null:
		controller_join_active = false
		_start_game([], true)
		return
	_refresh_controller_join_ui()
	if controller_connect_panel:
		controller_connect_panel.visible = true
	if controller_start_button:
		controller_start_button.disabled = false
		if nav_focus_enabled:
			controller_start_button.grab_focus()
	_update_ai_difficulty_visibility()


func _close_controller_connect() -> void:
	controller_join_active = false
	if controller_connect_panel:
		controller_connect_panel.visible = false


func _on_controller_connect_confirm_pressed() -> void:
	_play_select_sfx()
	var devices := join_inputs.duplicate()
	if devices.is_empty():
		_register_keyboard_join(false)
		devices = join_inputs.duplicate()
	_close_controller_connect()
	_open_character_select(devices)


func _on_controller_connect_cancel_pressed() -> void:
	_play_select_sfx()
	join_inputs.clear()
	_close_controller_connect()
	_show_title()


func _open_character_select(selected_inputs: Array) -> void:
	controller_join_active = false
	pending_player_inputs = selected_inputs.duplicate(true)
	selected_player_characters.clear()
	selected_player_characters.resize(3)
	player_characters.clear()
	character_selection_index = 0
	character_human_count = min(3, pending_player_inputs.size())
	if character_select_panel:
		character_select_panel.visible = true
	if character_human_count == 0:
		character_selection_index = -1
		_assign_ai_characters()
		_finalize_character_select()
		return
	_refresh_character_slots_ui(true)
	_build_character_option_grid()
	_update_character_prompt()
	if nav_focus_enabled:
		_maybe_focus_for_nav()


func _close_character_select() -> void:
	if character_select_panel:
		character_select_panel.visible = false


func _on_character_back_pressed() -> void:
	_play_select_sfx()
	var restore_inputs := pending_player_inputs.duplicate(true)
	_close_character_select()
	_open_controller_connect()
	join_inputs = restore_inputs
	_refresh_controller_join_ui()


func _build_character_option_grid() -> void:
	if character_option_grid == null or not is_instance_valid(character_option_grid):
		return
	_clear_children(character_option_grid)
	character_option_buttons.clear()
	for char_data: Dictionary in CHARACTER_ROSTER:
		var name := str(char_data.get("name", ""))
		var btn := Button.new()
		btn.text = name
		btn.custom_minimum_size = Vector2(180, 90)
		btn.focus_mode = Control.FOCUS_ALL
		var bg: Color = char_data.get("bg", Color(0.25, 0.25, 0.25))
		var accent: Color = char_data.get("accent", bg.darkened(0.2))
		var normal := StyleBoxFlat.new()
		normal.bg_color = bg
		normal.set_border_width_all(3)
		normal.border_color = accent
		normal.set_corner_radius_all(18)
		var hover := normal.duplicate()
		hover.bg_color = bg.lightened(0.08)
		var pressed := normal.duplicate()
		pressed.bg_color = bg.darkened(0.08)
		btn.add_theme_stylebox_override("normal", normal)
		btn.add_theme_stylebox_override("hover", hover)
		btn.add_theme_stylebox_override("pressed", pressed)
		btn.add_theme_color_override("font_color", Color(0.1, 0.1, 0.1))
		btn.add_theme_font_size_override("font_size", 20)
		if theme_styler:
			theme_styler.apply_font_override(btn, game_font)
			theme_styler.apply_body_color(btn)
		btn.pressed.connect(func() -> void: _on_character_option_pressed(name))
		character_option_grid.add_child(btn)
		character_option_buttons.append(btn)
	_refresh_character_option_states()


func _refresh_character_option_states() -> void:
	for btn in character_option_buttons:
		if btn == null:
			continue
		var taken := _is_character_taken(btn.text)
		btn.disabled = taken


func _on_character_option_pressed(name: String) -> void:
	if character_selection_index == -1:
		return
	if _is_character_taken(name):
		return
	var slot := _current_human_slot()
	if slot == -1:
		return
	selected_player_characters[slot] = _character_data_for(name)
	_refresh_character_slots_ui()
	character_selection_index = _next_human_slot(slot + 1)
	if character_selection_index == -1:
		_assign_ai_characters()
		_finalize_character_select()
	else:
		_update_character_prompt()
		_refresh_character_option_states()
		if nav_focus_enabled:
			_maybe_focus_for_nav()


func _current_human_slot() -> int:
	if character_selection_index < 0:
		return -1
	if character_selection_index >= character_human_count:
		return -1
	return character_selection_index


func _next_human_slot(start_idx: int) -> int:
	for i in range(start_idx, character_human_count):
		if (
			selected_player_characters[i] == null
			or (selected_player_characters[i] as Dictionary).is_empty()
		):
			return i
	return -1


func _assign_ai_characters() -> void:
	var available := _available_character_names()
	for i in range(character_human_count, 3):
		if available.is_empty():
			available = _available_character_names(true)
		if available.is_empty():
			break
		var pick_idx := rng.randi_range(0, available.size() - 1)
		var pick := available[pick_idx]
		available.remove_at(pick_idx)
		selected_player_characters[i] = _character_data_for(pick)
	_refresh_character_slots_ui()


func _available_character_names(ignore_taken: bool = false) -> Array[String]:
	var names: Array[String] = []
	for c in CHARACTER_ROSTER:
		var n := str((c as Dictionary).get("name", ""))
		if n == "":
			continue
		if not ignore_taken and _is_character_taken(n):
			continue
		names.append(n)
	return names


func _is_character_taken(name: String) -> bool:
	for entry in selected_player_characters:
		if typeof(entry) != TYPE_DICTIONARY:
			continue
		if str((entry as Dictionary).get("name", "")).to_lower() == name.to_lower():
			return true
	return false


func _character_data_for(name: String) -> Dictionary:
	for c in CHARACTER_ROSTER:
		if str((c as Dictionary).get("name", "")).to_lower() == name.to_lower():
			return (c as Dictionary).duplicate(true)
	return {"name": name, "bg": Color(0.2, 0.2, 0.2), "accent": Color(0.3, 0.3, 0.3)}


func _update_character_prompt() -> void:
	if character_prompt_label == null:
		return
	var slot := _current_human_slot()
	if slot == -1:
		if character_human_count == 0:
			character_prompt_label.text = _t(
				"AI characters will be assigned.", "Personagens IA serao definidos."
			)
		else:
			character_prompt_label.text = _t(
				"Finalizing characters...", "Finalizando personagens..."
			)
		return
	var input_desc := _human_input_description(slot)
	character_prompt_label.text = (
		_t("Player %d (%s): Choose a character", "Jogador %d (%s): Escolha um personagem")
		% [slot + 1, input_desc]
	)


func _human_input_description(slot: int) -> String:
	if slot < pending_player_inputs.size():
		var entry := pending_player_inputs[slot]
		var t := str((entry as Dictionary).get("type", "keyboard"))
		if t == "keyboard":
			return _t("Keyboard", "Teclado")
		return _t("Controller", "Controle")
	return _t("Player", "Jogador")


func _refresh_character_slots_ui(reset_empty: bool = false) -> void:
	for i in range(3):
		var label_text := _t("Player %d", "Jogador %d") % (i + 1)
		if i < character_human_count:
			label_text = "%s (%s)" % [label_text, _human_input_description(i)]
		else:
			label_text = _t("AI Slot %d", "Slot IA %d") % (i + 1)
		if character_slot_labels.size() > i and character_slot_labels[i]:
			character_slot_labels[i].text = label_text

		var has_selection := (
			i < selected_player_characters.size()
			and typeof(selected_player_characters[i]) == TYPE_DICTIONARY
			and not (selected_player_characters[i] as Dictionary).is_empty()
		)
		var hint_text := ""
		if has_selection:
			hint_text = str((selected_player_characters[i] as Dictionary).get("name", ""))
			if i >= character_human_count:
				hint_text += _t(" (AI)", " (IA)")
		else:
			hint_text = (
				_t("Select a character", "Selecione um personagem")
				if i < character_human_count
				else _t("Random (AI)", "Aleatorio (IA)")
			)
		if character_slot_hints.size() > i and character_slot_hints[i]:
			character_slot_hints[i].text = hint_text

		var color := Color(0.18, 0.18, 0.18, 1.0)
		if has_selection:
			color = (selected_player_characters[i] as Dictionary).get("bg", color)
		if character_slot_portraits.size() > i and character_slot_portraits[i]:
			character_slot_portraits[i].color = color

		if character_slot_panels.size() > i and character_slot_panels[i] and theme_styler:
			var tone := theme_styler.team_color(i)
			theme_styler.apply_team_card_style(character_slot_panels[i], tone, has_selection)
	_refresh_character_option_states()
	_update_character_prompt()


func _auto_assign_default_characters() -> void:
	player_characters.clear()
	var available := _available_character_names(true)
	for i in range(players.size()):
		if available.is_empty():
			available = _available_character_names(true)
		if available.is_empty():
			player_characters.append({})
			continue
		var idx := rng.randi_range(0, available.size() - 1)
		var pick := available[idx]
		available.remove_at(idx)
		player_characters.append(_character_data_for(pick))


func _finalize_character_select() -> void:
	player_characters = selected_player_characters.duplicate(true)
	for i in range(3):
		var missing := (
			i >= player_characters.size()
			or typeof(player_characters[i]) != TYPE_DICTIONARY
			or (player_characters[i] as Dictionary).is_empty()
		)
		if missing:
			if i >= player_characters.size():
				player_characters.append(_character_data_for("Player %d" % (i + 1)))
			else:
				player_characters[i] = _character_data_for("Player %d" % (i + 1))
	_close_character_select()
	_start_game(pending_player_inputs, false)
	pending_player_inputs.clear()


func _on_ai_difficulty_selected(idx: int) -> void:
	match idx:
		0:
			ai_difficulty = "easy"
		1:
			ai_difficulty = "normal"
		2:
			ai_difficulty = "hard"
		_:
			ai_difficulty = "normal"
	ai_correct_rate = AI_DIFFICULTY_RATES.get(ai_difficulty, AI_DIFFICULTY_RATES["normal"])
	_refresh_controller_join_ui()


func _start_game(selected_inputs: Array = [], allow_keyboard_fallback: bool = true) -> void:
	title_panel.visible = false
	settings_panel.visible = false
	player_select_panel.visible = false
	if controller_connect_panel:
		controller_connect_panel.visible = false
	if character_select_panel:
		character_select_panel.visible = false
	controller_join_active = false
	_reset_round_state()
	_setup_players(3, selected_inputs, allow_keyboard_fallback)
	if player_characters.is_empty():
		_auto_assign_default_characters()
	_apply_player_characters()
	game_root.visible = true
	question_panel.visible = false
	_build_teams()
	_build_board()
	_set_header_visible(true)


func _register_joined_controller(device_id: int) -> bool:
	if device_id < 0:
		return false
	if not Input.get_connected_joypads().has(device_id):
		return false
	for entry in join_inputs:
		if entry.get("type", "") == "joypad" and int(entry.get("device_id", -1)) == device_id:
			return false
	if join_inputs.size() >= 3:
		return false
	join_inputs.append({"type": "joypad", "device_id": device_id})
	nav_focus_enabled = true
	_refresh_controller_join_ui()
	_play_select_sfx()
	return true


func _register_keyboard_join(enable_focus: bool = false) -> bool:
	var has_keyboard := false
	for entry in join_inputs:
		if entry.get("type", "") == "keyboard":
			has_keyboard = true
			break
	if has_keyboard:
		return false
	if join_inputs.size() >= 3:
		return false
	join_inputs.append({"type": "keyboard", "device_id": null})
	if enable_focus:
		nav_focus_enabled = true
	_refresh_controller_join_ui()
	_play_select_sfx()
	return true


func _refresh_controller_join_ui() -> void:
	for i in range(3):
		if controller_slot_labels.size() > i and controller_slot_labels[i]:
			controller_slot_labels[i].text = _controller_slot_text(i + 1)
	var connected := Input.get_connected_joypads().size()
	if controller_status_label:
		controller_status_label.text = (
			_t("Connected controllers: %d", "Controles conectados: %d") % connected
		)
	if controller_ai_option:
		var hide_ai := _human_player_count_planned() >= 3
		controller_ai_option.visible = not hide_ai
		controller_ai_option.disabled = hide_ai
		if controller_ai_option.visible and controller_ai_option.selected < 0:
			controller_ai_option.select(1)
	if controller_ai_label:
		controller_ai_label.visible = controller_ai_option and controller_ai_option.visible
	for i in range(controller_slot_panels.size()):
		var panel := controller_slot_panels[i]
		if panel and theme_styler:
			var color := theme_styler.team_color(i)
			var has_join := i < join_inputs.size()
			theme_styler.apply_team_card_style(panel, color, has_join)


func _update_ai_difficulty_visibility() -> void:
	_refresh_controller_join_ui()


func _controller_slot_text(slot_index: int) -> String:
	if slot_index - 1 < join_inputs.size():
		var entry := join_inputs[slot_index - 1]
		var type := str(entry.get("type", ""))
		if type == "keyboard":
			return _t("Player %d: Keyboard", "Jogador %d: Teclado") % slot_index
		var dev_id := int(entry.get("device_id", -1))
		var joy_name := Input.get_joy_name(dev_id)
		if joy_name.strip_edges() == "":
			joy_name = _t("Controller %d", "Controle %d") % slot_index
		return _t("Player %d: %s", "Jogador %d: %s") % [slot_index, joy_name]
	return _t("Player %d: Press any button", "Jogador %d: Aperte qualquer botao") % slot_index


func _human_player_count_planned() -> int:
	return min(3, join_inputs.size())


func _input(event: InputEvent) -> void:
	# Handle Escape/UI cancel to toggle pause/menu return.
	if _handle_escape_input(event):
		return
	if pause_menu.visible:
		return
	if buzzed_player != -1 and not _event_matches_active_answerer(event):
		if not event.is_action_pressed("ui_cancel"):
			get_viewport().set_input_as_handled()
			return
	if controller_join_active:
		if event is InputEventJoypadButton and event.pressed:
			nav_focus_enabled = true
			_maybe_focus_for_nav()
			if _register_joined_controller((event as InputEventJoypadButton).device):
				get_viewport().set_input_as_handled()
				return
		elif event is InputEventJoypadMotion:
			var motion := event as InputEventJoypadMotion
			if abs(motion.axis_value) > 0.6:
				nav_focus_enabled = true
				_maybe_focus_for_nav()
				if _register_joined_controller(motion.device):
					get_viewport().set_input_as_handled()
					return
		elif event is InputEventKey and event.pressed and not event.is_echo():
			var key_event := event as InputEventKey
			if key_event.keycode != KEY_ESCAPE and key_event.physical_keycode != KEY_ESCAPE:
				if _register_keyboard_join():
					get_viewport().set_input_as_handled()
					return
		return

	if current_clue.is_empty() and not _event_is_for_current_turn(event):
		if not event.is_action_pressed("ui_cancel"):
			if (
				event is InputEventMouseButton
				or event is InputEventJoypadButton
				or event is InputEventJoypadMotion
				or event is InputEventKey
			):
				get_viewport().set_input_as_handled()
				return


func _can_open_pause_menu() -> bool:
	return player_select_panel.visible or game_root.visible or question_panel.visible


func _open_pause_menu() -> void:
	nav_focus_enabled = true
	if settings_panel:
		settings_panel.visible = false
	if pause_menu:
		pause_menu.visible = true
	if pause_resume_button:
		pause_resume_button.grab_focus()
	_maybe_focus_for_nav()


func _close_pause_menu() -> void:
	if pause_menu:
		pause_menu.visible = false
	get_viewport().set_input_as_handled()


func _on_pause_resume_pressed() -> void:
	_play_select_sfx()
	_close_pause_menu()
	_maybe_focus_for_nav()


func _on_pause_main_menu_pressed() -> void:
	_play_select_sfx()
	_restart_to_main_menu()


func _on_pause_settings_pressed() -> void:
	_play_select_sfx()
	settings_opened_from_pause = true
	_close_pause_menu()
	if settings_screen:
		settings_screen.show_settings_from_pause()
	if language_option and nav_focus_enabled:
		language_option.grab_focus()


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
		FinalJeopardyData.set_language(current_language)
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
	FinalJeopardyData.set_language(current_language)
	_apply_language_texts()
	_save_settings()
	_build_board()
	_build_teams()
	if final_wager_panel:
		final_wager_panel.visible = false


func _on_set_wager_pressed() -> void:
	if not final_round:
		return
	if final_question_revealed:
		return
	if final_wager_player < 0 or final_wager_player >= players.size():
		return
	var raw: String = ""
	if final_wager_input:
		raw = final_wager_input.text
	var wager: int = int(raw)
	var max_wager: int = (
		abs(team_scores[final_wager_player]) if team_scores.size() > final_wager_player else 0
	)
	var clamped: int = clamp(wager, 0, max_wager)
	current_wager = clamped
	_finalize_wager(final_wager_player, clamped)


func _finalize_wager(idx: int, amount: int, reason_text: String = "") -> void:
	if idx < 0 or idx >= players.size():
		return
	if idx >= final_wager_values.size():
		return
	final_wager_values[idx] = amount
	final_wager_done[idx] = true
	_maybe_finish_wagers()


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
	_open_controller_connect()


func _on_music_slider_changed(value: float) -> void:
	if audio_controller:
		audio_controller.set_music_volume_db(value)
	_save_settings()


func _setup_players(
	count: int, join_order: Array = [], allow_keyboard_fallback: bool = true
) -> void:
	players.clear()
	current_turn_team = 0
	var required_players: int = clamp(count, 1, 3)
	var resolved_inputs: Array[Dictionary] = []
	for entry in join_order:
		if resolved_inputs.size() >= required_players:
			break
		if typeof(entry) != TYPE_DICTIONARY:
			continue
		var type := str(entry.get("type", ""))
		if type != "joypad" and type != "keyboard":
			continue
		if type == "joypad":
			var dev_id := int(entry.get("device_id", -1))
			if dev_id < 0:
				continue
			var duplicate := false
			for e in resolved_inputs:
				if e.get("type", "") == "joypad" and int(e.get("device_id", -1)) == dev_id:
					duplicate = true
					break
			if duplicate:
				continue
			resolved_inputs.append({"type": "joypad", "device_id": dev_id})
		else:
			var has_keyboard := false
			for e in resolved_inputs:
				if e.get("type", "") == "keyboard":
					has_keyboard = true
					break
			if has_keyboard:
				continue
			resolved_inputs.append({"type": "keyboard", "device_id": null})

	if resolved_inputs.is_empty() and allow_keyboard_fallback:
		resolved_inputs.append({"type": "keyboard", "device_id": null})

	var slot := 0
	for input_entry in resolved_inputs:
		if players.size() >= required_players:
			break
		slot += 1
		var input_type := str(input_entry.get("type", "keyboard"))
		var dev_id: Variant = input_entry.get("device_id", null)
		var uses_keyboard := input_type == "keyboard"
		if uses_keyboard:
			dev_id = null
		elif dev_id != null:
			dev_id = int(dev_id)
		players.append(
			{
				"name": "Player %d" % slot,
				"is_ai": false,
				"device_id": dev_id,
				"uses_keyboard": uses_keyboard
			}
		)

	while players.size() < required_players:
		var idx := players.size() + 1
		players.append(
			{
				"name": "Player %d (AI)" % idx,
				"is_ai": true,
				"device_id": null,
				"uses_keyboard": false
			}
		)

	_update_player_info_label()
	_sync_team_names_from_players()


func _update_player_info_label() -> void:
	if board_screen:
		board_screen.update_player_info_label(
			player_info_label,
			func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
		)


func _sync_team_names_from_players() -> void:
	var names: Array[String] = []
	for p in players:
		names.append(str(p.get("name", "Player")))
	team_names = names


func _apply_player_characters() -> void:
	if player_characters.is_empty():
		return
	for i in range(min(players.size(), player_characters.size())):
		var char_data := player_characters[i]
		if typeof(char_data) != TYPE_DICTIONARY or char_data.is_empty():
			continue
		var display_name := str(char_data.get("name", "Player %d" % (i + 1)))
		players[i]["character"] = char_data
		players[i]["name"] = display_name
	_sync_team_names_from_players()


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()


func _build_teams() -> void:
	_stop_team_card_pulse()
	if board_screen:
		board_screen.build_teams(
			team_names,
			team_scores,
			team_score_labels,
			team_cards,
			team_trophies,
			team_wager_labels,
			player_characters,
			scoreboard,
			func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
		)
		_clear_trophies()
		_clear_wager_labels()

	if team_score_labels.size() > 0:
		_set_active_team(current_turn_team)
		turn_label.text = ""
	else:
		turn_label.text = _t("No teams configured", "Nenhum time configurado")


func _set_score_label(idx: int) -> void:
	if board_screen:
		board_screen.set_score_label(
			idx,
			team_scores,
			team_score_labels,
			func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
		)


func _clear_trophies() -> void:
	for t in team_trophies:
		if t and is_instance_valid(t):
			t.visible = false


func _clear_wager_labels() -> void:
	for w in team_wager_labels:
		if w and is_instance_valid(w):
			w.visible = false
			w.text = ""


func _show_winner_trophies() -> void:
	if team_scores.is_empty():
		return
	_clear_trophies()
	var max_score := team_scores[0]
	for s in team_scores:
		if s > max_score:
			max_score = s
	var winners: Array[String] = []
	for i in range(team_scores.size()):
		if team_scores[i] != max_score:
			continue
		if i < team_trophies.size():
			var trophy: Label = team_trophies[i] as Label
			if trophy and is_instance_valid(trophy):
				trophy.visible = true
		var name := team_names[i] if team_names.size() > i else "Player %d" % (i + 1)
		winners.append(name)
	if not winners.is_empty():
		_show_result(_t("Winner: %s", "Vencedor: %s") % ", ".join(winners), Color(0.2, 0.6, 0.2))


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
		if theme_styler:
			theme_styler.apply_font_override(cat_label, game_font)
			theme_styler.apply_body_color(cat_label)
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
			btn.focus_mode = Control.FOCUS_ALL
			if theme_styler:
				theme_styler.apply_font_override(btn, game_font)
				theme_styler.apply_body_color(btn)
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
	if final_round:
		if not final_wager_set:
			return
		if final_question_revealed:
			return
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
		if theme_styler:
			theme_styler.apply_font_override(btn, game_font)
			theme_styler.apply_body_color(btn)
		btn.pressed.connect(func() -> void: _on_answer_selected(opt))

		answer_button_nodes.append(btn)

		grid.add_child(btn)


func _open_answer_buttons_for(player_index: int) -> void:
	answer_buttons.visible = true
	for btn in answer_button_nodes:
		btn.disabled = false
	if nav_focus_enabled and not answer_button_nodes.is_empty() and answer_button_nodes[0]:
		answer_button_nodes[0].grab_focus()
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
	_lock_answering_input(player_index)
	_set_active_team(player_index)
	if theme_styler:
		_set_question_panel_color(theme_styler.team_color(player_index))
	var is_ai: bool = players[player_index].get("is_ai", false)

	if final_round:
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
	if final_round and final_question_revealed:
		_record_final_answer(answer_text)
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
		answering_input_lock.clear()
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
			var eligible_ai := _get_eligible_ai_players()
			if not eligible_ai.is_empty():
				var wait_delay := AI_BUZZ_DELAY if _human_player_count() >= 2 else 0.75
				_start_ai_buzz_timer(wait_delay)


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
	answering_input_lock.clear()
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
	if final_round:
		if not final_question_revealed:
			_maybe_finish_wagers()
			return
		if final_question_revealed and buzzed_player != -1:
			_record_final_answer("")
			return
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
	answering_input_lock.clear()
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
		_show_winner_trophies()
	else:
		board_grid.visible = true
		_set_header_visible(true)
		turn_label.text = ""
		_advance_round_if_needed()
		_maybe_trigger_ai_board_choice()


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
	answering_input_lock.clear()
	join_inputs.clear()
	controller_join_active = false
	nav_focus_enabled = false
	if controller_connect_panel:
		controller_connect_panel.visible = false
	final_round = false
	hidden_double_key = ""
	current_wager = 0
	final_question.clear()
	final_question_revealed = false
	final_wager_values.clear()
	final_wager_done.clear()
	final_answer_choices.clear()
	final_answered.clear()
	final_answer_index = 0
	players.clear()
	team_names.clear()
	team_scores.clear()
	team_score_labels.clear()
	team_cards.clear()
	team_trophies.clear()
	team_wager_labels.clear()
	player_characters.clear()
	selected_player_characters.clear()
	_stop_team_card_pulse()
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
	_cancel_wager_timer()

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
	if enabled:
		_focus_first_board_button()


func _show_result(text: String, color: Color = Color(0.1, 0.1, 0.1)) -> void:
	result_label.text = text
	result_label.add_theme_color_override("font_color", color)


func _focus_first_board_button() -> void:
	if board_grid == null or not is_instance_valid(board_grid):
		return
	if not board_grid.visible:
		return
	if not nav_focus_enabled:
		return
	for child in board_grid.get_children():
		if child is Button:
			var btn := child as Button
			if btn.disabled:
				continue
			btn.grab_focus()
			return


func _maybe_focus_for_nav() -> void:
	if not nav_focus_enabled:
		return
	var current_focus := get_viewport().gui_get_focus_owner()
	if current_focus and current_focus.visible:
		return
	if controller_connect_panel and controller_connect_panel.visible and controller_start_button:
		controller_start_button.grab_focus()
		return
	if character_select_panel and character_select_panel.visible:
		if not character_option_buttons.is_empty() and character_option_buttons[0]:
			character_option_buttons[0].grab_focus()
			return
		if character_back_button:
			character_back_button.grab_focus()
			return
	if settings_panel and settings_panel.visible and language_option:
		language_option.grab_focus()
		return
	if title_panel and title_panel.visible and title_play_button:
		title_play_button.grab_focus()
		return
	if board_grid and board_grid.visible:
		_focus_first_board_button()


func _lock_answering_input(player_index: int) -> void:
	answering_input_lock.clear()
	if player_index < 0 or player_index >= players.size():
		return
	var p := players[player_index]
	if p.get("is_ai", false):
		answering_input_lock = {"type": "ai"}
		return
	if p.get("uses_keyboard", false):
		answering_input_lock = {"type": "keyboard"}
		return
	answering_input_lock = {"type": "joypad", "device_id": int(p.get("device_id", -1))}


func _event_matches_active_answerer(event: InputEvent) -> bool:
	if answering_input_lock.is_empty():
		return true
	var t := str(answering_input_lock.get("type", ""))
	if t == "keyboard":
		return (
			event is InputEventKey
			or event is InputEventMouseButton
			or event is InputEventMouseMotion
		)
	if t == "joypad":
		var dev := int(answering_input_lock.get("device_id", -999))
		if event is InputEventJoypadButton or event is InputEventJoypadMotion:
			return int(event.device) == dev
		return false
	return false


func _event_is_for_current_turn(event: InputEvent) -> bool:
	if current_turn_team < 0 or current_turn_team >= players.size():
		return true
	return _event_for_player(current_turn_team, event)


func _event_for_player(idx: int, event: InputEvent) -> bool:
	if idx < 0 or idx >= players.size():
		return false
	var p: Dictionary = players[idx] as Dictionary
	var uses_keyboard: bool = p.get("uses_keyboard", false)
	var is_ai: bool = p.get("is_ai", false)
	if is_ai:
		return false
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if uses_keyboard:
			return false
		return int(event.device) == int(p.get("device_id", -1))
	if event is InputEventKey or event is InputEventMouseButton or event is InputEventMouseMotion:
		return uses_keyboard
	return true


func _maybe_trigger_ai_board_choice() -> void:
	if final_round:
		return
	if current_turn_team < 0 or current_turn_team >= players.size():
		return
	var p := players[current_turn_team]
	if not p.get("is_ai", false):
		return
	await get_tree().create_timer(AI_BOARD_PICK_DELAY).timeout
	var available: Array[Button] = []
	if board_grid and is_instance_valid(board_grid):
		for child in board_grid.get_children():
			if child is Button:
				var btn := child as Button
				if btn.disabled:
					continue
				available.append(btn)
	if available.is_empty():
		return
	var pick := available[rng.randi_range(0, available.size() - 1)]
	_on_clue_button_pressed(pick)


func _reset_round_state() -> void:
	round_index = 0
	final_round = false
	current_wager = 0
	final_wager_player = -1
	final_wager_set = false
	final_clue_used = false
	final_question.clear()
	final_question_revealed = false
	final_wager_values.clear()
	final_wager_done.clear()
	final_answer_choices.clear()
	final_answered.clear()
	final_answer_index = 0
	_cancel_wager_timer()
	hidden_double_key = ""
	current_categories.clear()
	current_options.clear()
	total_clues_this_round = 0
	category_deck = LoadedBibleData.get_categories()
	answered_map.clear()
	current_turn_team = 0
	answering_player = -1
	team_trophies.clear()
	team_wager_labels.clear()
	_clear_wager_labels()
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
	attempted_players.clear()
	final_wager_player = -1
	final_wager_set = false
	final_clue_used = false
	final_question_revealed = false
	final_answer_index = 0
	final_question = FinalJeopardyData.get_random_question()
	final_wager_values.clear()
	final_wager_done.clear()
	final_answer_choices.clear()
	final_answered.clear()
	for i in range(players.size()):
		final_wager_values.append(0)
		final_wager_done.append(false)
		final_answer_choices.append("")
		final_answered.append(false)
	_stop_timers(true)
	_end_question_audio()
	_clear_children(board_grid)
	board_grid.visible = false
	_set_header_visible(true)

	current_clue.clear()
	current_categories = []

	q_category_label.text = _t("Final Round: Wagers", "Rodada final: Apostas")
	q_value_label.text = _t("Place your wagers", "Defina suas apostas")
	q_text_label.text = ""
	result_label.text = _t(
		"Choose 30%, 50% or 100% of your points.", "Escolha 30%, 50% ou 100% dos seus pontos."
	)
	_disable_answer_buttons()
	if final_wager_panel:
		final_wager_panel.visible = false
	if final_clue_button:
		final_clue_button.disabled = true
	question_panel.visible = true
	game_root.visible = true
	_set_board_input_enabled(false)
	_build_parallel_wager_ui()


func _calculate_auto_wager(idx: int) -> int:
	if idx < 0 or idx >= team_scores.size():
		return 0
	return int(round(abs(team_scores[idx]) * 0.1))


func _build_parallel_wager_ui() -> void:
	_cancel_ai_buzz_timer()
	_cancel_wager_timer()
	_clear_wager_labels()
	final_wager_player = -1
	final_wager_set = false
	current_wager = 0
	if final_wager_panel:
		_clear_children(final_wager_panel)
		final_wager_panel.visible = true
	if final_wager_input:
		final_wager_input.visible = false
	if final_wager_button:
		final_wager_button.visible = false
	if final_clue_button:
		final_clue_button.disabled = true
		final_clue_button.visible = false

	var title := Label.new()
	title.text = _t("Final Wagers", "Apostas Finais")
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if theme_styler:
		theme_styler.apply_font_override(title, game_font)
		theme_styler.apply_body_color(title)
	title.add_theme_font_size_override("font_size", 30)
	if final_wager_panel:
		final_wager_panel.add_child(title)

	var container := VBoxContainer.new()
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	if final_wager_panel:
		final_wager_panel.add_child(container)

	for i in range(players.size()):
		var row := HBoxContainer.new()
		row.alignment = BoxContainer.ALIGNMENT_CENTER
		row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.size_flags_vertical = Control.SIZE_FILL
		row.add_theme_constant_override("separation", 18)

		var name: String = players[i].get("name", "Player %d" % (i + 1))
		var score: int = team_scores[i] if team_scores.size() > i else 0
		var label := Label.new()
		label.text = "%s (%s)" % [name, _t("Points: %d", "Pontos: %d") % score]
		if theme_styler:
			theme_styler.apply_font_override(label, game_font)
			theme_styler.apply_body_color(label)
		label.add_theme_font_size_override("font_size", 22)
		row.add_child(label)

		if score < 0:
			var auto_wager: int = _calculate_auto_wager(i)
			final_wager_values[i] = auto_wager
			final_wager_done[i] = true
			var auto_label := Label.new()
			auto_label.text = _t("Auto 10%: %d", "Auto 10%: %d") % auto_wager
			if theme_styler:
				theme_styler.apply_font_override(auto_label, game_font)
				theme_styler.apply_body_color(auto_label)
			row.add_child(auto_label)
			container.add_child(row)
			continue

		if players[i].get("is_ai", false):
			var ai_choice: int = int(round(abs(score) * 0.5))
			final_wager_values[i] = ai_choice
			final_wager_done[i] = true
			var ai_label := Label.new()
			ai_label.text = _t("AI wager: %d", "Aposta IA: %d") % ai_choice
			if theme_styler:
				theme_styler.apply_font_override(ai_label, game_font)
				theme_styler.apply_body_color(ai_label)
			row.add_child(ai_label)
			container.add_child(row)
			continue

		var percents := [
			{"text": "30%", "pct": 0.3}, {"text": "50%", "pct": 0.5}, {"text": "100%", "pct": 1.0}
		]
		for p in percents:
			var btn := Button.new()
			btn.text = p["text"]
			btn.custom_minimum_size = Vector2(120, 60)
			if theme_styler:
				theme_styler.apply_font_override(btn, game_font)
				theme_styler.apply_body_color(btn)
			btn.add_theme_font_size_override("font_size", 22)
			var pct_val: float = p["pct"]
			btn.pressed.connect(func() -> void: _on_wager_choice(i, pct_val))
			row.add_child(btn)

		container.add_child(row)

	_start_wager_timer()
	_maybe_finish_wagers()


func _on_wager_choice(idx: int, pct: float) -> void:
	if idx < 0 or idx >= players.size():
		return
	var score: int = abs(team_scores[idx]) if team_scores.size() > idx else 0
	var wager: int = int(round(score * pct))
	final_wager_values[idx] = wager
	final_wager_done[idx] = true
	_maybe_finish_wagers()


func _maybe_finish_wagers() -> void:
	for i in range(players.size()):
		if i >= final_wager_done.size():
			return
		if not final_wager_done[i]:
			return
	_show_wager_labels_then_reveal()


func _show_wager_labels_then_reveal() -> void:
	if final_wager_panel:
		final_wager_panel.visible = false
	for i in range(players.size()):
		if i >= final_wager_values.size():
			continue
		if i < team_wager_labels.size():
			var lbl: Label = team_wager_labels[i] as Label
			if lbl and is_instance_valid(lbl):
				lbl.text = _t("Wager: %d", "Aposta: %d") % final_wager_values[i]
				lbl.visible = true
	var summary_timer := get_tree().create_timer(5.0)
	summary_timer.timeout.connect(_on_wager_summary_timeout)


func _on_wager_summary_timeout() -> void:
	_clear_wager_labels()
	_reveal_final_question()


func _on_all_wagers_done() -> void:
	final_wager_player = -1
	final_wager_set = true
	_reveal_final_question()


func _reveal_final_question() -> void:
	final_question_revealed = true
	_cancel_ai_buzz_timer()
	_disable_answer_buttons()
	if final_wager_panel:
		final_wager_panel.visible = false
	question_panel.visible = true
	_set_header_visible(true)

	var clue := final_question
	if clue.is_empty():
		if category_deck.is_empty():
			category_deck = LoadedBibleData.get_categories()
		if category_deck.is_empty():
			return
		var fallback_cat: Dictionary = (
			category_deck[rng.randi_range(0, category_deck.size() - 1)] as Dictionary
		)
		var values: Array = fallback_cat.get("values", [])
		if not values.is_empty():
			var hardest_index: int = min(2, values.size() - 1)
			var pool: Array = (values[hardest_index] as Dictionary).get("pool", [])
			if not pool.is_empty():
				clue = pool[rng.randi_range(0, pool.size() - 1)] as Dictionary
				clue["category"] = fallback_cat.get("name", _t("Final Jeopardy", "Rodada final"))
	if clue.is_empty():
		return

	var category_name := str(clue.get("category", _t("Final Jeopardy", "Rodada final")))
	var question_text := str(clue.get("question", ""))

	current_clue = {
		"cat_index": 0,
		"clue_index": 0,
		"value": 0,
		"button": null,
		"answer": clue.get("answer", ""),
		"is_double": false,
		"decoys": clue.get("decoys", [])
	}

	current_categories = [{"name": category_name, "values": []}]

	q_category_label.text = _t("Final Round: %s", "Rodada final: %s") % category_name
	q_value_label.text = _t("Select your answers", "Escolha suas respostas")
	q_text_label.text = ""
	result_label.text = _t(
		"Final question revealed. Answer in turn.", "Pergunta final revelada. Responda em sua vez."
	)
	_build_answer_options(current_clue)
	q_text_label.text = question_text
	is_typing_question = false
	_start_tts(question_text)
	_begin_final_answers()


func _begin_final_answers() -> void:
	final_answer_index = 0
	buzzed_player = -1
	answering_player = -1
	_prompt_final_answer_for(_next_unanswered_index(-1))


func _next_unanswered_index(start_idx: int) -> int:
	for i in range(start_idx + 1, players.size()):
		if i < final_answered.size() and not final_answered[i]:
			return i
	for i in range(players.size()):
		if i < final_answered.size() and not final_answered[i]:
			return i
	return -1


func _prompt_final_answer_for(idx: int) -> void:
	_disable_answer_buttons()
	_stop_timers(true)
	if idx == -1:
		_resolve_final_answers()
		return
	buzzed_player = idx
	answering_player = idx
	_lock_answering_input(idx)
	if theme_styler:
		_set_question_panel_color(theme_styler.team_color(idx))
	_set_active_team(idx)
	var name: String = players[idx].get("name", "Player %d" % (idx + 1))
	turn_label.text = _t("Answer: %s", "Responder: %s") % name
	result_label.text = _t("Choose an answer (30s).", "Escolha uma resposta (30s).")
	for btn in answer_button_nodes:
		if btn:
			btn.disabled = false
	if answer_buttons:
		answer_buttons.visible = true
	if nav_focus_enabled and not answer_button_nodes.is_empty() and answer_button_nodes[0]:
		answer_button_nodes[0].grab_focus()
	_start_answer_timer()
	_cancel_ai_buzz_timer()
	if players[idx].get("is_ai", false):
		_queue_ai_answer()


func _record_final_answer(answer_text: String) -> void:
	if buzzed_player == -1:
		return
	var idx := buzzed_player
	if idx < final_answer_choices.size():
		final_answer_choices[idx] = answer_text
	if idx < final_answered.size():
		final_answered[idx] = true
	_stop_timers(true)
	_disable_answer_buttons()
	buzzed_player = -1
	answering_player = -1
	answering_input_lock.clear()
	var next_idx := _next_unanswered_index(idx)
	if next_idx == -1:
		_resolve_final_answers()
	else:
		_prompt_final_answer_for(next_idx)


func _resolve_final_answers() -> void:
	_stop_timers(true)
	_disable_answer_buttons()
	_stop_team_card_pulse()
	var correct_answer: String = str(current_clue.get("answer", "")).strip_edges().to_lower()
	for i in range(players.size()):
		var wager := final_wager_values[i] if i < final_wager_values.size() else 0
		var choice := ""
		if i < final_answer_choices.size():
			choice = final_answer_choices[i]
		var is_correct := str(choice).strip_edges().to_lower() == correct_answer
		if is_correct:
			team_scores[i] += wager
		else:
			team_scores[i] -= wager
		if i < team_score_labels.size():
			_set_score_label(i)

	result_label.text = _t("Answer: %s", "Resposta: %s") % str(current_clue.get("answer", ""))
	_show_result("", Color(0.1, 0.1, 0.1))
	turn_label.text = _t("Final scores", "Pontuacao final")
	if scoreboard:
		scoreboard.visible = true
	if title_label:
		title_label.visible = false
	if question_panel:
		question_panel.visible = false
	_set_header_visible(true)
	_show_winner_trophies()


func _set_header_visible(visible: bool) -> void:
	title_label.visible = visible
	scoreboard.visible = true
	turn_label.visible = true


func _unhandled_input(event: InputEvent) -> void:
	if pause_menu.visible:
		return
	if controller_join_active:
		return
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		nav_focus_enabled = true
		_maybe_focus_for_nav()
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
		if (
			key_event.keycode == KEY_SPACE
			or key_event.keycode == KEY_ENTER
			or key_event.keycode == KEY_KP_ENTER
		):
			for i in range(players.size()):
				var p: Dictionary = players[i] as Dictionary
				if p.get("is_ai", false):
					continue
				if not p.get("uses_keyboard", false):
					continue
				return i
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


func _get_eligible_ai_players() -> Array[int]:
	var candidates: Array[int] = []
	for i in range(players.size()):
		var p: Dictionary = players[i] as Dictionary
		if not p.get("is_ai", false):
			continue
		if attempted_players.has(i):
			continue
		candidates.append(i)
	return candidates


func _human_player_count() -> int:
	var count := 0
	for p in players:
		if not (p as Dictionary).get("is_ai", false):
			count += 1
	return count


func _on_ai_try_buzz() -> void:
	if current_clue.is_empty():
		return
	if buzzed_player != -1:
		return
	var candidates := _get_eligible_ai_players()
	if candidates.is_empty():
		return
	var pick_index := rng.randi_range(0, candidates.size() - 1)
	_on_player_buzz(candidates[pick_index])


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


func _start_wager_timer() -> void:
	_cancel_wager_timer()
	final_wager_timer = get_tree().create_timer(FINAL_WAGER_TIME)
	final_wager_timer.timeout.connect(_on_final_wager_timeout)


func _cancel_wager_timer() -> void:
	if final_wager_timer:
		if final_wager_timer.timeout.is_connected(_on_final_wager_timeout):
			final_wager_timer.timeout.disconnect(_on_final_wager_timeout)
		final_wager_timer = null


func _on_final_wager_timeout() -> void:
	for i in range(players.size()):
		if i >= final_wager_done.size():
			continue
		if final_wager_done[i]:
			continue
		var score: int = abs(team_scores[i]) if team_scores.size() > i else 0
		var auto_wager: int = _calculate_auto_wager(i)
		final_wager_values[i] = auto_wager
		final_wager_done[i] = true
	_maybe_finish_wagers()


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

	var pick_correct := rng.randf() < ai_correct_rate
	var choice := correct_raw
	if not pick_correct and not wrong_choices.is_empty():
		choice = wrong_choices[rng.randi_range(0, wrong_choices.size() - 1)]

	_on_answer_selected(choice)


func _ensure_default_input_actions() -> void:
	_ensure_action_with_events(
		"ui_accept",
		[
			_make_key_event(KEY_ENTER),
			_make_key_event(KEY_KP_ENTER),
			_make_key_event(KEY_SPACE),
			_make_joypad_button_event(JOY_BUTTON_A)
		]
	)
	_ensure_action_with_events(
		"ui_cancel", [_make_key_event(KEY_ESCAPE), _make_joypad_button_event(JOY_BUTTON_B)]
	)
	_ensure_action_with_events(
		"pause",
		[
			_make_key_event(KEY_ESCAPE),
			_make_key_event(KEY_P),
			_make_joypad_button_event(JOY_BUTTON_START),
			_make_joypad_button_event(JOY_BUTTON_BACK)
		]
	)
	_ensure_action_with_events(
		"ui_up",
		[
			_make_key_event(KEY_UP),
			_make_key_event(KEY_W),
			_make_joypad_button_event(JOY_BUTTON_DPAD_UP),
			_make_joypad_axis_event(JOY_AXIS_LEFT_Y, -1.0)
		]
	)
	_ensure_action_with_events(
		"ui_down",
		[
			_make_key_event(KEY_DOWN),
			_make_key_event(KEY_S),
			_make_joypad_button_event(JOY_BUTTON_DPAD_DOWN),
			_make_joypad_axis_event(JOY_AXIS_LEFT_Y, 1.0)
		]
	)
	_ensure_action_with_events(
		"ui_left",
		[
			_make_key_event(KEY_LEFT),
			_make_key_event(KEY_A),
			_make_joypad_button_event(JOY_BUTTON_DPAD_LEFT),
			_make_joypad_axis_event(JOY_AXIS_LEFT_X, -1.0)
		]
	)
	_ensure_action_with_events(
		"ui_right",
		[
			_make_key_event(KEY_RIGHT),
			_make_key_event(KEY_D),
			_make_joypad_button_event(JOY_BUTTON_DPAD_RIGHT),
			_make_joypad_axis_event(JOY_AXIS_LEFT_X, 1.0)
		]
	)


func _ensure_action_with_events(action: String, events: Array) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action, 0.5)
	for ev in events:
		if ev == null:
			continue
		if not InputMap.action_has_event(action, ev):
			InputMap.action_add_event(action, ev)


func _make_key_event(keycode: int) -> InputEventKey:
	var ev := InputEventKey.new()
	ev.device = -1
	ev.physical_keycode = keycode
	ev.keycode = keycode
	return ev


func _make_joypad_button_event(button_index: int) -> InputEventJoypadButton:
	var ev := InputEventJoypadButton.new()
	ev.device = -1
	ev.button_index = button_index
	return ev


func _make_joypad_axis_event(axis: int, value: float) -> InputEventJoypadMotion:
	var ev := InputEventJoypadMotion.new()
	ev.device = -1
	ev.axis = axis
	ev.axis_value = value
	return ev


func _t(en_text: String, pt_text: String) -> String:
	return pt_text if current_language == "pt" else en_text


func _handle_escape_input(event: InputEvent) -> bool:
	if pause_menu == null:
		return false
	var esc_pressed := event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")
	if not esc_pressed and event is InputEventKey:
		var key_event := event as InputEventKey
		esc_pressed = key_event.pressed and not key_event.echo and key_event.keycode == KEY_ESCAPE
	if esc_pressed:
		if controller_connect_panel and controller_connect_panel.visible:
			_on_controller_connect_cancel_pressed()
			get_viewport().set_input_as_handled()
			return true
		if settings_panel.visible and settings_opened_from_pause:
			_play_select_sfx()
			settings_opened_from_pause = false
			if settings_screen:
				settings_screen.back_to_pause()
			else:
				settings_panel.visible = false
				_open_pause_menu()
		elif pause_menu.visible:
			_play_select_sfx()
			_close_pause_menu()
		elif _can_open_pause_menu():
			_play_select_sfx()
			_open_pause_menu()
			_maybe_focus_for_nav()
		get_viewport().set_input_as_handled()
		return true
	return false


func _setup_pause_menu_focus() -> void:
	var btns := [pause_resume_button, pause_main_menu_button, pause_settings_button]
	for b in btns:
		if b:
			b.focus_mode = Control.FOCUS_ALL
	_set_pause_focus_chain()


func _set_pause_focus_chain() -> void:
	if pause_resume_button and pause_main_menu_button and pause_settings_button:
		var resume_path := pause_resume_button.get_path()
		var settings_path := pause_settings_button.get_path()
		var main_path := pause_main_menu_button.get_path()

		# Order matches visual stack: Resume -> Settings -> Main Menu (wraps)
		pause_resume_button.focus_neighbor_top = main_path
		pause_resume_button.focus_neighbor_bottom = settings_path

		pause_settings_button.focus_neighbor_top = resume_path
		pause_settings_button.focus_neighbor_bottom = main_path

		pause_main_menu_button.focus_neighbor_top = settings_path
		pause_main_menu_button.focus_neighbor_bottom = resume_path

		# Keep left/right on the same button to avoid jumping elsewhere
		pause_resume_button.focus_neighbor_left = resume_path
		pause_resume_button.focus_neighbor_right = resume_path
		pause_settings_button.focus_neighbor_left = settings_path
		pause_settings_button.focus_neighbor_right = settings_path
		pause_main_menu_button.focus_neighbor_left = main_path
		pause_main_menu_button.focus_neighbor_right = main_path

		# Tab order follows the same downward flow
		pause_resume_button.focus_next = settings_path
		pause_settings_button.focus_next = main_path
		pause_main_menu_button.focus_next = resume_path
