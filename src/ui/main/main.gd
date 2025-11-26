extends Control

@export var game_font: Font = preload("res://fonts/Comic Sans MS.ttf")
@export var title_texture: Texture2D = preload("res://game title.png")
@export var bible_character_textures: Array[Texture2D] = []

const LoadedBibleData = preload("res://src/data/bible_data.gd")
const VerseData = preload("res://src/data/verse_data.gd")
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
const AI_DIFFICULTY_RATES := {"easy": 0.2, "normal": 0.4, "hard": 0.7}
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
	if online_host_button:
		online_host_button.pressed.connect(_on_online_host_pressed)
	if online_join_button:
		online_join_button.pressed.connect(_on_online_join_pressed)
	if online_back_button:
		online_back_button.pressed.connect(_on_online_back_pressed)
	if online_host_start_button:
		online_host_start_button.pressed.connect(_on_online_start_pressed)
	if online_host_leave_button:
		online_host_leave_button.pressed.connect(_on_online_leave_pressed)
	if online_join_connect_button:
		online_join_connect_button.pressed.connect(_on_online_join_connect_pressed)
	if online_join_cancel_button:
		online_join_cancel_button.pressed.connect(_on_online_back_pressed)
	if online_join_code_input:
		online_join_code_input.text_submitted.connect(
			func(_t: String) -> void: _on_online_join_connect_pressed()
		)
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
	var mp := get_tree().get_multiplayer()
	if mp:
		if not mp.peer_connected.is_connected(_on_peer_connected):
			mp.peer_connected.connect(_on_peer_connected)
		if not mp.peer_disconnected.is_connected(_on_peer_disconnected):
			mp.peer_disconnected.connect(_on_peer_disconnected)
		if not mp.connected_to_server.is_connected(_on_connected_to_server):
			mp.connected_to_server.connect(_on_connected_to_server)
		if not mp.connection_failed.is_connected(_on_connection_failed):
			mp.connection_failed.connect(_on_connection_failed)
		if not mp.server_disconnected.is_connected(_on_server_disconnected):
			mp.server_disconnected.connect(_on_server_disconnected)
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
	if main_menu_screen:
		main_menu_screen.apply_language_texts(
			current_language, func(lang: String) -> void: LoadedBibleData.set_language(lang)
		)
	_update_player_info_label()
	_apply_controller_connect_text()
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
		title_online_button,
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
		controller_slot_labels[2] if controller_slot_labels.size() > 2 else null,
		controller_ai_label,
		controller_ai_option,
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
	theme_styler.apply_game_font(game_font, font_controls)

	background_rect = theme_styler.setup_background(self, background_rect)

	var primary_controls: Array = [
		title_play_button,
		title_online_button,
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
		title_online_button,
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
	_refresh_controller_join_ui()


func _set_active_team(idx: int) -> void:
	if idx < 0 or idx >= team_cards.size():
		current_turn_team = clamp(idx, 0, max(0, team_cards.size() - 1))
	else:
		current_turn_team = idx
	if theme_styler:
		theme_styler.refresh_team_highlight(team_cards, current_turn_team)


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
	if online_panel:
		online_panel.visible = false
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


func _on_online_pressed() -> void:
	_play_select_sfx()
	_show_online_menu()


func _on_settings_back_pressed() -> void:
	_play_select_sfx()
	if settings_opened_from_pause:
		settings_opened_from_pause = false
		if settings_screen:
			settings_screen.back_to_pause()
	else:
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
	_update_online_panel_visibility(false, false)
	_update_online_status("", false)
	if nav_focus_enabled and online_host_button:
		online_host_button.grab_focus()


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


func _on_online_back_pressed() -> void:
	_shutdown_online_session()
	_show_title()


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
	join_inputs.clear()
	_start_game(devices, false)


func _on_controller_connect_cancel_pressed() -> void:
	_play_select_sfx()
	join_inputs.clear()
	_close_controller_connect()
	_show_title()


func _on_online_host_pressed() -> void:
	_play_select_sfx()
	_update_online_panel_visibility(true, false)
	_create_host_room()


func _on_online_join_pressed() -> void:
	_play_select_sfx()
	_update_online_panel_visibility(false, true)
	_update_online_status("", false)
	if online_join_code_input:
		online_join_code_input.clear()
	if online_join_ip_input:
		online_join_ip_input.text = (
			online_join_ip_input.text if online_join_ip_input.text != "" else "127.0.0.1"
		)
	if nav_focus_enabled and online_join_code_input:
		online_join_code_input.grab_focus()


func _on_online_join_connect_pressed() -> void:
	_play_select_sfx()
	if online_join_code_input == null or online_join_ip_input == null:
		return
	var code := online_join_code_input.text.strip_edges()
	if code == "":
		_update_online_status(_t("Enter a room code.", "Digite um codigo de sala."), true)
		return
	var port := int(code)
	if port <= 0:
		_update_online_status(_t("Invalid room code.", "Codigo invalido."), true)
		return
	var ip := online_join_ip_input.text.strip_edges()
	if ip == "":
		ip = "127.0.0.1"
	_update_online_status(_t("Connecting...", "Conectando..."), false)
	_connect_to_room(ip, port, code)


func _on_online_start_pressed() -> void:
	_play_select_sfx()
	if not online_is_host:
		return
	if online_players.size() < ONLINE_MIN_PLAYERS:
		_update_online_status(
			_t("Need at least 2 players to start.", "Precisa de pelo menos 2 jogadores."), true
		)
		return
	_rpc_start_online_game.rpc(online_players)
	_begin_online_game(online_players, true)


func _on_online_leave_pressed() -> void:
	_play_select_sfx()
	_shutdown_online_session()
	_update_online_panel_visibility(false, false)
	_update_online_status("", false)


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
	controller_join_active = false
	_reset_round_state()
	_setup_players(3, selected_inputs, allow_keyboard_fallback)
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
		Color(0.2, 0.8, 0.4),
		true
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
	_show_result(hint + _t(" (-10% wager)", " (-10% da aposta)"), Color(0.9, 0.7, 0.1), true)


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

	# Sync team names from players
	var names: Array[String] = []
	for p in players:
		names.append(p["name"])
	team_names = names


func _update_player_info_label() -> void:
	if board_screen:
		board_screen.update_player_info_label(
			player_info_label,
			func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
		)


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()


func _build_teams() -> void:
	if board_screen:
		board_screen.build_teams(
			team_names,
			team_scores,
			team_score_labels,
			team_cards,
			scoreboard,
			func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
		)

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


func _set_team_name_label(idx: int, name: String) -> void:
	if idx < 0 or idx >= team_cards.size():
		return
	var card := team_cards[idx]
	if card == null or not is_instance_valid(card):
		return
	if card.get_child_count() == 0:
		return
	var vbox := card.get_child(0)
	if vbox == null or vbox.get_child_count() == 0:
		return
	var maybe_label := vbox.get_child(0)
	if maybe_label is Label:
		(maybe_label as Label).text = name


func _build_board() -> void:
	if round_index >= ROUND_VALUES.size():
		_start_final_round()
		return

	question_panel.visible = false
	_set_header_visible(true)
	_show_result("", Color(0.1, 0.1, 0.1), true)
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
	if online_active and not online_is_host:
		if online_host_peer_id <= 0:
			return
		_rpc_request_clue.rpc_id(online_host_peer_id, cat_index, clue_index)
		return
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
		_show_result(_t("Double points!", "Pontos em dobro!"), Color(0.9, 0.7, 0.1), true)
	else:
		_show_result("", Color(1, 1, 1), true)
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
	if online_active and online_is_host:
		_rpc_remote_start_clue.rpc(
			{
				"cat_index": cat_index,
				"clue_index": clue_index,
				"value": score_value,
				"is_double": is_double,
				"answer": clue["answer"],
				"question": question_text,
				"options": current_options.duplicate(true),
				"cat_name": str(cat_data["name"])
			}
		)
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
	if online_active and not online_is_host:
		if player_index == local_player_index and online_host_peer_id > 0:
			_rpc_request_buzz.rpc_id(online_host_peer_id, player_index)
		return

	buzzed_player = player_index
	answering_player = player_index
	_lock_answering_input(player_index)
	_set_active_team(player_index)
	if theme_styler:
		_set_question_panel_color(theme_styler.team_color(player_index))
	var is_ai: bool = players[player_index].get("is_ai", false)

	if final_round:
		# ... your existing final round wager logic ...
		return
	if online_active and online_is_host:
		_rpc_remote_buzz.rpc(player_index)

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
	if online_active and not online_is_host:
		if online_host_peer_id > 0:
			_rpc_request_answer.rpc_id(online_host_peer_id, answer_text)
		return
	if final_round and not final_wager_set:
		_show_result(
			_t("Set your wager first.", "Defina sua aposta antes."), Color(0.9, 0.3, 0.3), true
		)
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
			Color(0.2, 0.7, 0.2),
			true
		)
		turn_label.text = (
			_t("Correct: %s", "Correto: %s") % players[buzzed_player].get("name", "Player")
		)
		_mark_clue_answered()
		question_panel.visible = false
		_set_board_input_enabled(true)
		if online_active and online_is_host:
			_rpc_remote_scores.rpc(team_scores)
			_rpc_remote_mark_answered.rpc(
				current_clue.get("cat_index", -1), current_clue.get("clue_index", -1)
			)
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
				Color(0.8, 0.2, 0.2),
				true
			)
			turn_label.text = _t("Wrong. Waiting for buzz...", "Errado. Aguardando outro buzzer...")
			_update_turn_label_waiting()
			_disable_answer_buttons()
			var eligible_ai := _get_eligible_ai_players()
			if not eligible_ai.is_empty():
				var wait_delay := AI_BUZZ_DELAY if _human_player_count() >= 2 else 0.75
				_start_ai_buzz_timer(wait_delay)
		if online_active and online_is_host:
			_rpc_remote_scores.rpc(team_scores)


func _update_turn_label_waiting() -> void:
	turn_label.text = _t("Waiting for buzz...", "Aguardando buzzer...")


func _disable_answer_buttons() -> void:
	for btn in answer_button_nodes:
		btn.disabled = true
	answer_buttons.visible = false


func _handle_all_attempted() -> void:
	_show_result("", Color(0.1, 0.1, 0.1), true)
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
	_start_answer_timer_internal(false)


func _start_answer_timer_internal(force_all: bool) -> void:
	if (
		online_active
		and not online_is_host
		and not force_all
		and buzzed_player != local_player_index
	):
		return
	if (
		answer_timer_bar
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("restart")
	):
		answer_timer_bar.restart(ANSWER_TIME)  # full 30s, from scratch
	if online_active and online_is_host and not force_all:
		_rpc_remote_timer_start.rpc(ANSWER_TIME)


func _on_answer_timer_timeout() -> void:
	if online_active and not online_is_host:
		return
	if (
		answer_timer_bar
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("stop")
	):
		answer_timer_bar.stop()
	# Time up, nobody got it right
	_show_result(_t("Time's up!", "Tempo esgotado!"), Color(0.8, 0.4, 0.0), true)
	if online_active and online_is_host:
		_rpc_remote_mark_answered.rpc(
			current_clue.get("cat_index", -1), current_clue.get("clue_index", -1)
		)
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
	else:
		board_grid.visible = true
		_set_header_visible(true)
		turn_label.text = ""
		_advance_round_if_needed()
	if online_active and online_is_host:
		_rpc_remote_mark_answered.rpc(cat_index, clue_index)
		_maybe_trigger_ai_board_choice()


func _restart_to_main_menu() -> void:
	_end_question_audio()
	_stop_timers()
	settings_opened_from_pause = false
	_shutdown_online_session()
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
	if online_active and online_is_host:
		_rpc_remote_timer_stop.rpc(preserve_result)


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
				var should_enable := enabled
				if online_active and not online_is_host:
					should_enable = false
				btn.disabled = not should_enable
	board_grid.visible = enabled
	if enabled:
		_focus_first_board_button()


func _show_result(
	text: String, color: Color = Color(0.1, 0.1, 0.1), broadcast: bool = false
) -> void:
	result_label.text = text
	result_label.add_theme_color_override("font_color", color)
	if broadcast and online_active and online_is_host:
		_rpc_remote_result.rpc(text, color)


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
	if settings_panel and settings_panel.visible and language_option:
		language_option.grab_focus()
		return
	if title_panel and title_panel.visible and title_play_button:
		title_play_button.grab_focus()
		return
	if board_grid and board_grid.visible:
		_focus_first_board_button()
	if online_panel and online_panel.visible:
		if online_host_button:
			online_host_button.grab_focus()


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


func _generate_room_code() -> String:
	return str(rng.randi_range(20000, 60000))


func _create_host_room() -> void:
	_shutdown_online_session()
	var port := int(_generate_room_code())
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_server(port, ONLINE_MAX_PLAYERS - 1)
	if err != OK:
		_update_online_status(_t("Failed to host room.", "Falha ao criar sala."), true)
		return
	online_peer = peer
	var mp := get_tree().get_multiplayer()
	if mp:
		if mp.has_method("set_unique_id") and mp.multiplayer_peer == null:
			mp.set_unique_id(rng.randi_range(1000, 999999))
		mp.multiplayer_peer = peer
		online_host_peer_id = mp.get_unique_id()
	else:
		online_host_peer_id = rng.randi_range(1000, 999999)
	online_is_host = true
	online_room_code = str(port)
	online_players.clear()
	var self_id := mp.get_unique_id() if mp else online_host_peer_id
	online_players.append({"id": self_id, "name": _t("Host", "Anfitriao")})
	_update_online_status(
		_t("Room created. Share the code.", "Sala criada. Compartilhe o codigo."), false
	)
	if online_code_value:
		online_code_value.text = online_room_code
	_update_online_lobby_labels()
	_broadcast_lobby()


func _connect_to_room(ip: String, port: int, code: String) -> void:
	_shutdown_online_session()
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_client(ip, port)
	if err != OK:
		_update_online_status(_t("Unable to connect.", "Nao foi possivel conectar."), true)
		return
	online_peer = peer
	online_is_host = false
	online_host_peer_id = -1  # Will be updated on lobby sync
	online_room_code = code
	var mp := get_tree().get_multiplayer()
	if mp:
		mp.multiplayer_peer = peer
	_update_online_status(_t("Connecting...", "Conectando..."), false)


func _shutdown_online_session() -> void:
	var mp := get_tree().get_multiplayer()
	if mp and mp.multiplayer_peer:
		mp.multiplayer_peer.close()
		mp.multiplayer_peer = null
	online_peer = null
	online_is_host = false
	online_active = false
	local_player_index = -1
	online_room_code = ""
	online_host_peer_id = -1
	online_players.clear()
	_update_online_lobby_labels()
	_update_online_status("", false)


func _update_online_lobby_labels() -> void:
	if online_code_value:
		online_code_value.text = online_room_code if online_room_code != "" else "----"
	for i in range(ONLINE_MAX_PLAYERS):
		if i < online_slot_labels.size() and online_slot_labels[i]:
			var label := online_slot_labels[i]
			if i < online_players.size():
				var p := online_players[i]
				label.text = _t("Slot %d: %s", "Vaga %d: %s") % [i + 1, str(p.get("name", "--"))]
			else:
				label.text = _t("Slot %d: --", "Vaga %d: --") % (i + 1)
	if online_host_start_button:
		online_host_start_button.disabled = online_players.size() < ONLINE_MIN_PLAYERS


func _broadcast_lobby() -> void:
	_rpc_lobby_update.rpc(online_players, online_host_peer_id)


@rpc("any_peer", "reliable", "call_local")
func _rpc_lobby_update(lobby: Array, host_id: int) -> void:
	online_host_peer_id = host_id
	online_players = lobby.duplicate(true)
	_update_online_lobby_labels()


@rpc("any_peer", "reliable", "call_local")
func _rpc_start_online_game(lobby: Array) -> void:
	_begin_online_game(lobby, online_is_host)


func _begin_online_game(lobby: Array, is_host: bool) -> void:
	online_is_host = is_host
	online_players = lobby.duplicate(true)
	online_active = true
	_update_online_status("", false)
	title_panel.visible = false
	settings_panel.visible = false
	player_select_panel.visible = false
	if online_panel:
		online_panel.visible = false
	_close_pause_menu()
	controller_join_active = false
	_reset_round_state()
	team_names.clear()
	players.clear()
	team_scores.clear()
	team_score_labels.clear()
	team_cards.clear()
	var mp := get_tree().get_multiplayer()
	var my_id := mp.get_unique_id() if mp else 1
	local_player_index = -1
	for entry in online_players:
		var pid := int((entry as Dictionary).get("id", -1))
		var name := str((entry as Dictionary).get("name", "Player"))
		var is_local := pid == my_id
		if is_local:
			local_player_index = players.size()
		players.append(
			{
				"name": name + (" (You)" if is_local else ""),
				"is_ai": false,
				"device_id": null,
				"uses_keyboard": is_local,
				"net_id": pid
			}
		)
	while players.size() < ONLINE_MAX_PLAYERS:
		var idx := players.size() + 1
		players.append(
			{
				"name": "AI %d" % idx,
				"is_ai": true,
				"device_id": null,
				"uses_keyboard": false,
				"net_id": -1
			}
		)
	for p in players:
		team_names.append(p.get("name", "Player"))
	team_scores.resize(players.size())
	for i in range(team_scores.size()):
		team_scores[i] = 0
	game_root.visible = true
	question_panel.visible = false
	_build_teams()
	_build_board()
	_set_header_visible(true)
	_play_background_music()


func _on_peer_connected(id: int) -> void:
	if online_peer == null:
		return
	if not online_is_host:
		return
	if online_players.size() >= ONLINE_MAX_PLAYERS:
		online_peer.disconnect_peer(id)
		return
	var idx := online_players.size() + 1
	online_players.append({"id": id, "name": _t("Player %d", "Jogador %d") % idx})
	_update_online_lobby_labels()
	_broadcast_lobby()
	_update_online_status(_t("Player joined.", "Jogador entrou."), false)


func _on_peer_disconnected(id: int) -> void:
	if online_peer == null:
		return
	var removed := false
	for i in range(online_players.size() - 1, -1, -1):
		if int((online_players[i] as Dictionary).get("id", -1)) == id:
			online_players.remove_at(i)
			removed = true
	if online_active:
		var p_idx := _player_index_from_peer(id)
		if p_idx != -1 and p_idx < players.size():
			var trigger_choice := p_idx == current_turn_team
			var ai_name := _set_player_to_ai(p_idx, "", trigger_choice)
			if online_is_host:
				_rpc_remote_swap_to_ai.rpc(p_idx, ai_name, trigger_choice)
		_update_online_status(
			_t("Player disconnected; swapped to AI.", "Jogador saiu; trocado por IA."), true
		)
	else:
		if removed:
			_update_online_lobby_labels()
	if online_is_host:
		_broadcast_lobby()


func _on_connected_to_server() -> void:
	_update_online_status(
		_t("Connected. Waiting for lobby...", "Conectado. Aguardando sala..."), false
	)


func _on_connection_failed() -> void:
	_update_online_status(_t("Connection failed.", "Conexao falhou."), true)
	_shutdown_online_session()


func _on_server_disconnected() -> void:
	_update_online_status(_t("Disconnected from host.", "Desconectado do anfitriao."), true)
	_shutdown_online_session()


@rpc("any_peer", "reliable")
func _rpc_request_clue(cat_index: int, clue_index: int) -> void:
	if not online_is_host:
		return
	var sender := get_tree().get_multiplayer().get_remote_sender_id()
	var idx := _player_index_from_peer(sender)
	if idx == -1:
		return
	var btn := _find_board_button(cat_index, clue_index)
	if btn:
		_on_clue_button_pressed(btn)


@rpc("any_peer", "reliable")
func _rpc_request_buzz(player_index: int) -> void:
	if not online_is_host:
		return
	var sender := get_tree().get_multiplayer().get_remote_sender_id()
	var idx := _player_index_from_peer(sender)
	if idx != player_index:
		return
	_on_player_buzz(player_index)


@rpc("any_peer", "reliable")
func _rpc_request_answer(answer_text: String) -> void:
	if not online_is_host:
		return
	_on_answer_selected(answer_text)


@rpc("authority", "reliable")
func _rpc_remote_start_clue(data: Dictionary) -> void:
	if online_is_host:
		return
	_apply_remote_clue(data)


@rpc("authority", "reliable")
func _rpc_remote_buzz(player_index: int) -> void:
	if online_is_host:
		return
	_apply_remote_buzz(player_index)


@rpc("authority", "reliable")
func _rpc_remote_scores(scores: Array) -> void:
	if online_is_host:
		return
	if scores.size() != team_scores.size():
		return
	for i in range(scores.size()):
		team_scores[i] = int(scores[i])
		_set_score_label(i)


@rpc("authority", "reliable")
func _rpc_remote_swap_to_ai(player_index: int, name: String, trigger_turn_choice: bool) -> void:
	if online_is_host:
		return
	_set_player_to_ai(player_index, name, trigger_turn_choice)


func forced_set_score_label(idx: int) -> void:
	if idx < 0 or idx >= team_scores.size():
		return
	if idx < team_score_labels.size():
		team_score_labels[idx].text = _t("Points: %s", "Pontos: %s") % team_scores[idx]


@rpc("authority", "reliable")
func _rpc_remote_mark_answered(cat_index: int, clue_index: int) -> void:
	if online_is_host:
		return
	var key := "%d-%d" % [cat_index, clue_index]
	answered_map[key] = true
	var btn := _find_board_button(cat_index, clue_index)
	if btn:
		btn.disabled = true
		btn.text = ""
	board_grid.visible = true
	_set_header_visible(true)


func _find_board_button(cat_index: int, clue_index: int) -> Button:
	if board_grid == null or not is_instance_valid(board_grid):
		return null
	for child in board_grid.get_children():
		if child is Button:
			var btn := child as Button
			if (
				btn.get_meta("cat_index", -1) == cat_index
				and btn.get_meta("clue_index", -1) == clue_index
			):
				return btn
	return null


func _apply_remote_clue(data: Dictionary) -> void:
	_reset_question_panel_color()
	var cat_index: int = data.get("cat_index", -1)
	var clue_index: int = data.get("clue_index", -1)
	var score_value: int = data.get("value", 0)
	var is_double: bool = data.get("is_double", false)
	var question_text := str(data.get("question", ""))
	var cat_name := str(data.get("cat_name", ""))
	current_options = (data.get("options", []) as Array).duplicate(true)
	current_clue = {
		"cat_index": cat_index,
		"clue_index": clue_index,
		"value": score_value,
		"button": null,
		"answer": data.get("answer", ""),
		"is_double": is_double
	}
	q_category_label.text = _t("Category: %s", "Categoria: %s") % cat_name
	q_value_label.text = _t("Value: %s", "Valor: %s") % str(score_value)
	q_text_label.text = question_text
	current_wager = 0
	buzzed_player = -1
	attempted_players.clear()
	if answer_timer_bar:
		answer_timer_bar.stop()
	_disable_answer_buttons()
	_build_answers_from_options(current_options)
	question_panel.visible = true
	board_grid.visible = false
	_set_header_visible(false)


func _build_answers_from_options(options: Array) -> void:
	if options.is_empty():
		return
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

	for opt in options:
		var btn := Button.new()
		btn.text = str(opt)
		btn.disabled = true
		btn.focus_mode = Control.FOCUS_ALL
		btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		btn.custom_minimum_size = Vector2(320, 160)
		btn.add_theme_font_size_override("font_size", 28)
		if theme_styler:
			theme_styler.apply_font_override(btn, game_font)
			theme_styler.apply_body_color(btn)
		btn.pressed.connect(func() -> void: _on_answer_selected(str(opt)))
		answer_button_nodes.append(btn)
		grid.add_child(btn)


func _apply_remote_buzz(player_index: int) -> void:
	buzzed_player = player_index
	answering_player = player_index
	_set_active_team(player_index)
	if theme_styler:
		_set_question_panel_color(theme_styler.team_color(player_index))
	if player_index == local_player_index:
		_open_answer_buttons_for(player_index)
		_start_answer_timer_internal(true)
	else:
		_disable_answer_buttons()
		turn_label.text = (
			_t("Buzzed: %s", "Buzzer: %s") % players[player_index].get("name", "Player")
		)


@rpc("authority", "reliable")
func _rpc_remote_result(text: String, color: Color) -> void:
	if online_is_host:
		return
	_show_result(text, color)


@rpc("authority", "reliable")
func _rpc_remote_timer_stop(preserve_result: bool) -> void:
	if online_is_host:
		return
	_stop_timers(preserve_result)


@rpc("authority", "reliable")
func _rpc_remote_timer_start(duration: float) -> void:
	if online_is_host:
		return
	if (
		answer_timer_bar
		and is_instance_valid(answer_timer_bar)
		and answer_timer_bar.has_method("restart")
	):
		answer_timer_bar.restart(duration)


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
			_show_result(
				_t("Round %d!", "Rodada %d!") % (round_index + 1), Color(0.6, 0.8, 1.0), true
			)
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
	_show_result(
		_t("Final round! Buzz to set your wager.", "Rodada final! Aperte para definir sua aposta."),
		Color(0.1, 0.1, 0.1),
		true
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
	if online_active and not online_is_host:
		if local_player_index >= 0:
			return local_player_index
		return local_player_index
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


func _player_index_from_peer(peer_id: int) -> int:
	for i in range(players.size()):
		var p := players[i]
		if int((p as Dictionary).get("net_id", -1)) == peer_id:
			return i
	return -1


func _set_player_to_ai(
	idx: int, override_name: String = "", trigger_turn_choice: bool = true
) -> String:
	if idx < 0 or idx >= players.size():
		return ""
	var name := override_name.strip_edges()
	if name == "":
		name = str(players[idx].get("name", "Player"))
	if not name.to_lower().contains("(ai"):
		name = "%s (AI)" % name
	players[idx]["is_ai"] = true
	players[idx]["uses_keyboard"] = false
	players[idx]["net_id"] = -1
	players[idx]["name"] = name
	if team_names.size() > idx:
		team_names[idx] = name
	_set_team_name_label(idx, name)
	_set_score_label(idx)
	if trigger_turn_choice and idx == current_turn_team and (not online_active or online_is_host):
		_maybe_trigger_ai_board_choice()
	return name


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
		if online_panel and online_panel.visible:
			_on_online_back_pressed()
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
