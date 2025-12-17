extends Control
class_name Main

@export var game_font: Font = preload("res://fonts/troika.otf")
@export var title_texture: Texture2D = preload("res://logo.png")
@export var bible_character_textures: Array[Texture2D] = []
@export var show_state_debug: bool = false

const LoadedBibleData = preload("res://src/data/bible_data.gd")
const VerseData = preload("res://src/data/verse_data.gd")
const FinalJeopardyData = preload("res://src/data/final_jeopardy_data.gd")
const GameStateMachine = preload("res://src/ui/main/game_state_machine.gd")
const GameSessionState = preload("res://src/ui/main/game_session_state.gd")
const ThemeStyler = preload("res://src/ui/main/theme_styler.gd")
const AudioController = preload("res://src/ui/main/audio_controller.gd")
const MainMenuScreen = preload("res://src/ui/screens/main_menu_screen.gd")
const SettingsScreen = preload("res://src/ui/screens/settings_screen.gd")
const MUSIC_BACKGROUND := preload("res://music/background music.mp3")
const MUSIC_QUESTION := preload("res://music/question music.mp3")
const SFX_CORRECT := preload("res://music/correct.mp3")
const SFX_WRONG := preload("res://music/wrong answer.mp3")
const SFX_SELECT := preload("res://music/Abstract2.mp3")
const MUSIC_BUS := "Master"
const TEAM_COLORS := [Color(0.9, 0.2, 0.2), Color(0.2, 0.45, 0.95), Color(0.15, 0.75, 0.35)] # Red  # Blue  # Green
const BOARD_CATEGORY_COUNT := 4
const BOARD_TILE_ROWS := 3
const BOARD_TILE_COUNT := BOARD_CATEGORY_COUNT * BOARD_TILE_ROWS

const QUESTION_CHAR_DELAY := 0.03
@export var reading_timer_seconds: float = 30.0
@export var answering_timer_seconds: float = 30.0
@export var selected_choice_display_seconds: float = 1.0
@export var ai_buzz_delay_seconds: float = 1.0
@export var ai_board_pick_delay_seconds: float = 5.0
@export var active_player_scale: float = 1.5
@export var inactive_player_opacity: float = 0.5
@export var result_display_seconds: float = 3.0
@export var final_wager_summary_delay_seconds: float = 3.0
@export var final_answer_lock_seconds: float = 3.0
@export var final_answer_reveal_seconds: float = 3.0
@export var final_results_duration_seconds: float = 10.0
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

# Main Menu UI
@onready var title_panel: Control = get_node_or_null("MainMenu")
@onready var title_play_button: Button = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/PlayMarginContainer/PlayButton"
)
@onready var title_settings_button: BaseButton = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/SettingsMarginContainer/SettingsButton"
)
@onready var title_logo: TextureRect = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/TitleLogo"
)
@onready var title_logo_main: TextureRect = get_node_or_null("TitleLogoMain")
@onready var title_screen_title: Label = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/Title"
)
@onready var verse_panel: PanelContainer = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/VerseMarginContainer/VerseOfDay"
)
@onready var verse_title_label: Label = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/VerseMarginContainer/VerseOfDay/MarginContainer/CardVBox/VerseTitle"
)
@onready var verse_text_label: Label = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/VerseMarginContainer/VerseOfDay/MarginContainer/CardVBox/VerseText"
)
@onready var verse_reference_label: Label = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/VerseMarginContainer/VerseOfDay/MarginContainer/CardVBox/VerseReference"
)

# Settings UI
@onready var settings_panel: Control = get_node_or_null("SettingsPanel")
@onready var settings_language_label: Label = get_node_or_null(
	"SettingsPanel/Content/SettingsGUI/CenterContainer/VBoxContainer/PanelContainer/VBox/LanguageLabel"
)
@onready var language_option: OptionButton = get_node_or_null(
	"SettingsPanel/Content/SettingsGUI/CenterContainer/VBoxContainer/PanelContainer/VBox/LanguageOption"
)
@onready var music_slider: HSlider = get_node_or_null(
	"SettingsPanel/Content/SettingsGUI/CenterContainer/VBoxContainer/PanelContainer/VBox/MusicSlider"
)
@onready var music_label: Label = get_node_or_null(
	"SettingsPanel/Content/SettingsGUI/CenterContainer/VBoxContainer/PanelContainer/VBox/MusicLabel"
)
@onready var settings_back_button: Button = get_node_or_null(
	"SettingsPanel/Content/SettingsGUI/CenterContainer/VBoxContainer/HBoxContainer/BackButtonContainer/BackButton"
)
@onready var settings_exit_button: Button = get_node_or_null(
	"SettingsPanel/Content/SettingsGUI/CenterContainer/VBoxContainer/HBoxContainer/ExitButtonContainer/ExitButton"
)

# Audio Players
@onready var music_player: AudioStreamPlayer = get_node_or_null("MusicPlayer")
@onready var question_music_player: AudioStreamPlayer = get_node_or_null("QuestionMusicPlayer")
@onready var sfx_correct_player: AudioStreamPlayer = get_node_or_null("CorrectSfxPlayer")
@onready var sfx_wrong_player: AudioStreamPlayer = get_node_or_null("WrongSfxPlayer")
@onready var sfx_select_player: AudioStreamPlayer = get_node_or_null("SelectSfxPlayer")

# Pause Menu UI
@onready var pause_menu: Control = get_node_or_null("PauseMenu")
@onready var pause_title_label: Label = get_node_or_null("PauseMenu/Panel/VBox/PauseLabel")
@onready var pause_resume_button: Button = get_node_or_null("PauseMenu/Panel/VBox/ResumeButton")
@onready var pause_main_menu_button: Button = get_node_or_null("PauseMenu/Panel/VBox/MainMenuButton")
@onready var pause_settings_button: Button = get_node_or_null("PauseMenu/Panel/VBox/SettingsButton")

# Controller Connect UI
@onready var controller_connect_panel: Control = get_node_or_null("ConnectControllersPanel")
@onready var controller_title_label: Label = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/ConnectTitle"
)
@onready var controller_subtitle_label: Label = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxSubtitleContainer/Subtitle"
)
@onready var controller_slot_labels: Array[Label] = [
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer1/Panel/MarginContainer/VBoxContainer/Label"
	),
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer2/Panel2/MarginContainer/VBoxContainer/Label"
	),
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer3/Panel2/MarginContainer/VBoxContainer/Label"
	)
]
@onready var controller_slot_panels: Array[PanelContainer] = [
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer1/Panel/MarginContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer2/Panel2/MarginContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer3/Panel2/MarginContainer/VBoxContainer/Label2"
	)
]
@onready var controller_slot_status_labels: Array[Label] = [
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer1/Panel/MarginContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer2/Panel2/MarginContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxPlayerContainer/MarginPlayerContainer3/Panel2/MarginContainer/VBoxContainer/Label2"
	)
]
@onready var controller_status_label: Label = get_node_or_null(
	"ConnectControllersPanel/Content/VBox/StatusLabel"
)
@onready var controller_difficulty_label: Label = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxDiffultyContainer/Label"
)
@onready var controller_ai_label: Label = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxDiffultyContainer/Label"
)
@onready var controller_ai_option: OptionButton = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxDiffultyContainer/OptionButton"
)
@onready var controller_continue_button: Button = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxButtonContainer/ContinueContainer/ContinueButton"
)
@onready var controller_back_button: Button = get_node_or_null(
	"ConnectControllersPanel/MarginContainer/PanelContainer/VBox/HBoxButtonContainer/BackContainer/BackButton"
)
@onready
var controller_connect_content: PanelContainer = get_node_or_null("ConnectControllersPanel/Content")

# Game UI
@onready var question_panel: Control = get_node_or_null("QuestionPanel")
@onready var q_category_label: Label = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/VBoxContainer2/QuestionCategory"
)
@onready var q_value_label: Label = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/VBoxContainer2/QuestionValue"
)
@onready var question_header_container: Control = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/VBoxContainer2"
)
@onready var q_text_label: Label = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/QuestionContainer/QuestionText"
)
@onready var question_container: Control = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/QuestionContainer"
)
@onready var result_label: Label = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/ResultContainer/ResultLabel"
)
@onready var result_container: Control = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/ResultContainer"
)
@onready var answer_timer_label: Label = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/TimerMarginContainer/Panel/Timer"
)
@onready var answer_container: Control = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/AnswerContainer"
)
@onready var answer_buttons: Control = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer"
)
@onready var answer_choice1: Button = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer/AnswerButton"
)
@onready var answer_choice2: Button = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer2/AnswerButton"
)
@onready var answer_choice3: Button = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer3/AnswerButton"
)
@onready var answer_choice4: Button = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer4/AnswerButton"
)
@onready var selected_choice_label: Label = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/SelectedChoice/MarginContainer/ChoiceContainer/ChoicePanel/ChoiceLabel"
)
@onready var selected_choice_container: Control = get_node_or_null(
	"QuestionPanel/Content/VBoxContainer/QuestionPanel/MarginContainer/QuestionVBox/SelectedChoice"
)
@onready var question_player_name_labels: Array[Label] = [
	get_node_or_null(
		"QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label"
	),
	get_node_or_null(
		"QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label"
	),
	get_node_or_null(
		"QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label"
	)
]
@onready var question_player_score_labels: Array[Label] = [
	get_node_or_null(
		"QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label2"
	)
]
@onready var board_player_panels: Array[Control] = [
	get_node_or_null("GameBoard/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel"),
	get_node_or_null("GameBoard/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel"),
	get_node_or_null("GameBoard/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel")
]
@onready var question_player_panels: Array[Control] = [
	get_node_or_null("QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel"),
	get_node_or_null("QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel"),
	get_node_or_null("QuestionPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel")
]
@onready var final_results_panel: Control = get_node_or_null("FinalResultsPanel")
@onready var final_results_name_labels: Array[Label] = [
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label"),
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label"),
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label")
]
@onready var final_results_score_labels: Array[Label] = [
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label2"),
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label2"),
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label2")
]
@onready var final_results_place_labels: Array[Label] = [
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/Placement"),
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/Placement"),
	get_node_or_null("FinalResultsPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/Placement")
]
@onready var wager_panel: Control = get_node_or_null("WagerPanel")
@onready var wager_category_label: Label = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerCategory/Category"
)
@onready var wager_category_panel: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerCategory"
)
@onready var wager_question_panel: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel"
)
@onready var wager_question_container: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/QuestionContainer"
)
@onready var wager_q_text_label: Label = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/QuestionContainer/QuestionText"
)
@onready var wager_result_container: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/ResultContainer"
)
@onready var wager_result_label: Label = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/ResultContainer/ResultLabel"
)
@onready var wager_answer_container: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/AnswerContainer"
)
@onready var wager_answer_buttons_parent: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer"
)
@onready var wager_answer_choice1: Button = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer/AnswerButton"
)
@onready var wager_answer_choice2: Button = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer2/AnswerButton"
)
@onready var wager_answer_choice3: Button = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer3/AnswerButton"
)
@onready var wager_answer_choice4: Button = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/AnswerContainer/GridContainer/AnswerContainer4/AnswerButton"
)
@onready var wager_selected_choice_label: Label = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/SelectedChoice/MarginContainer/ChoiceContainer/ChoicePanel/ChoiceLabel"
)
@onready var wager_selected_choice_container: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/WagerQuestionPanel/MarginContainer/QuestionVBox/SelectedChoice"
)
@onready var wager_spacer_panel: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/SpacerPanel"
)
@onready var wager_hbox_player_container: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer"
)
@onready var wager_timer_label: Label = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/TimerMarginContainer/Panel/Timer"
)
@onready var wager_timer_container: Control = get_node_or_null(
	"WagerPanel/Content/VBoxContainer/TimerMarginContainer"
)
@onready
var wager_container: Control = get_node_or_null("WagerPanel/Content/VBoxContainer/WagerContainer")
@onready var wager_top_name_labels: Array[Label] = [
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label"
	)
]
@onready var wager_top_score_labels: Array[Label] = [
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label2"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label2"
	)
]
@onready var wager_player_name_labels: Array[Label] = [
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/WagerContainer/Panel/PlayerWagerContainer1/PlayerName"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/WagerContainer/Panel2/PlayerWagerContainer1/PlayerName"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/WagerContainer/Panel3/PlayerWagerContainer1/PlayerName"
	)
]
@onready var wager_amount_labels: Array[Label] = [
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/WagerContainer/Panel/PlayerWagerContainer1/WagerAmount"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/WagerContainer/Panel2/PlayerWagerContainer1/WagerAmount"
	),
	get_node_or_null(
		"WagerPanel/Content/VBoxContainer/WagerContainer/Panel3/PlayerWagerContainer1/WagerAmount"
	)
]
@onready var wager_choice_buttons: Array = [
	[
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice"
		),
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice2"
		),
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice3"
		)
	],
	[
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel2/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice"
		),
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel2/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice2"
		),
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel2/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice3"
		)
	],
	[
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel3/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice"
		),
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel3/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice2"
		),
		get_node_or_null(
			"WagerPanel/Content/VBoxContainer/WagerContainer/Panel3/PlayerWagerContainer1/WagerChoiceContainer/WagerChoice3"
		)
	]
]

# Game Board UI
@onready var game_board: GameBoard = get_node_or_null("GameBoard")
@onready var board_settings_button: Button = get_node_or_null(
	"GameBoard/Content/VBoxContainer/SettingsMarginContainer/SettingsButton"
)

# Settings
@onready var play_button: Button = get_node_or_null(
	"MainMenu/baseMenuScreen/NinePatchRect/MarginContainer/VBoxContainer/PlayMarginContainer/PlayButton"
)

var answer_button_nodes: Array[Button] = []
var wager_answer_button_nodes: Array[Button] = []
var active_answer_button_nodes: Array[Button] = []
var active_question_text_label: Label = null
var active_result_label: Label = null
var active_question_container: Control = null
var active_result_container: Control = null
var active_answer_container: Control = null
var active_answer_buttons_parent: Control = null
var active_selected_choice_label: Label = null
var active_selected_choice_container: Control = null
var active_timer_label: Label = null
var using_wager_question_ui: bool = false
var answer_countdown_timer: SceneTreeTimer = null
var answer_time_left: int = 0

var team_names: Array[String] = []
var players: Array[Dictionary] = [] # {name, is_ai, device_id, uses_keyboard}
var team_scores: Array[int] = []
var team_score_labels: Array[Label] = []
var team_cards: Array[PanelContainer] = []
var team_trophies: Array[Label] = []
var team_wager_labels: Array[Label] = []
var team_card_pulse_tween: Tween = null
var base_board_sizes: Array[Vector2] = []
var base_question_sizes: Array[Vector2] = []
var base_board_inner_heights: Array[float] = []
var base_question_inner_heights: Array[float] = []

enum QuestionPhase {IDLE, READING, ANSWERING, SHOWING_SELECTED, SHOWING_RESULT}

var current_clue: Dictionary = {}
var answered_map: Dictionary = {} # key: "catIndex-clueIndex" -> true
var current_categories: Array = []
var current_options: Array[String] = []

var is_typing_question: bool = false
var buzzed_player: int = -1
var attempted_players: Array[int] = []
var ai_buzz_timer: SceneTreeTimer
var rng := RandomNumberGenerator.new()
var current_language: String = "en"
var bible_data: LoadedBibleData = LoadedBibleData.new()
var join_inputs: Array[Dictionary] = [] # Ordered join list of controllers/keyboard
var pending_player_inputs: Array[Dictionary] = []
var pending_allow_keyboard_fallback: bool = true
var player_characters: Array[Dictionary] = []
var controller_join_active: bool = false
var answering_input_lock: Dictionary = {}
var nav_focus_enabled: bool = false # Only grab focus highlights when a controller/keyboard joins
var settings_opened_from_pause: bool = false
var ai_difficulty: String = "normal"
var ai_correct_rate: float = AI_DIFFICULTY_RATES["normal"]
var local_player_index: int = -1
var round_index: int = 0
var hidden_double_key: String = ""
var total_clues_this_round: int = 0
var current_wager: int = 0
var final_wager_player: int = -1
var final_wager_set: bool = false
var final_question: Dictionary = {}
var final_question_revealed: bool = false
var final_wager_values: Array[int] = []
var final_wager_done: Array[bool] = []
var final_answer_choices: Array[String] = []
var final_answered: Array[bool] = []
var final_wager_timer: SceneTreeTimer
var final_wager_countdown_timer: SceneTreeTimer
var final_wager_time_left: int = 0
var final_answer_index: int = 0
var final_results_timer: SceneTreeTimer
var current_turn_team: int = 0
var question_selector_team: int = 0
var answering_player: int = -1
var background_rect: TextureRect
var theme_body_color: Color = Color("#633005")
var music_bus_idx: int = -1
var music_amp_effect_idx: int = -1
var music_amp: AudioEffectAmplify = null
var category_deck: Array = []
var loading_settings: bool = false
var settings_initialized: bool = false
var verse_data := VerseData.new()
var question_panel_base_style: StyleBox = null
var theme_styler: ThemeStyler
var audio_controller: AudioController
var game_state_machine: GameStateMachine
var main_menu_screen: MainMenuScreen
var settings_screen: SettingsScreen
var state_debug_label: Label
var default_game_alignment: int = BoxContainer.ALIGNMENT_CENTER
const SETTINGS_PATH := "user://settings.cfg"

var question_phase: int = QuestionPhase.IDLE


func _safe_connect_pressed(button: BaseButton, callback: Callable, label: String) -> void:
	if button and is_instance_valid(button):
		button.pressed.connect(callback)
	else:
		push_warning("%s missing; skipping pressed connection" % label)


func _safe_connect_value_changed(slider: Range, callback: Callable, label: String) -> void:
	if slider and is_instance_valid(slider):
		slider.value_changed.connect(callback)
	else:
		push_warning("%s missing; skipping value_changed connection" % label)


func _safe_connect_item_selected(
	option_button: OptionButton, callback: Callable, label: String
) -> void:
	if option_button and is_instance_valid(option_button):
		option_button.item_selected.connect(callback)
	else:
		push_warning("%s missing; skipping item_selected connection" % label)


func _safe_clear_option(option_button: OptionButton, label: String) -> bool:
	if option_button and is_instance_valid(option_button):
		option_button.clear()
		return true
	push_warning("%s missing; skipping clear" % label)
	return false


func _set_button_label_text(button: BaseButton, text: String) -> void:
	if button == null or not is_instance_valid(button):
		return
	var lbl: Label = button.get_node_or_null("Label") as Label
	if lbl:
		lbl.text = text
		if button is Button:
			(button as Button).text = ""
	elif button is Button:
		(button as Button).text = text


func _safe_set_visible(node: Node, value: bool) -> void:
	if node and is_instance_valid(node):
		node.visible = value


func _safe_focus_path(btns: Array, idx: int, fallback_idx: int) -> NodePath:
	if idx < 0 or idx >= btns.size():
		idx = fallback_idx
	var target := btns[idx] as Control
	if target and is_instance_valid(target):
		return target.get_path()
	var fallback := btns[fallback_idx] as Control
	return fallback.get_path() if fallback and is_instance_valid(fallback) else NodePath("")


func _wire_focus_grid(btns: Array, columns: int, wrap: bool = true) -> void:
	# btns: Array[BaseButton]
	var total := btns.size()
	if total == 0 or columns <= 0:
		return

	var rows := int(ceil(float(total) / float(columns)))

	for i in range(total):
		var btn := btns[i] as BaseButton
		if btn == null or not is_instance_valid(btn):
			continue

		btn.focus_mode = Control.FOCUS_ALL

		var r := i / columns
		var c := i % columns

		var left_i := r * columns + (c - 1)
		var right_i := r * columns + (c + 1)
		var up_i := (r - 1) * columns + c
		var down_i := (r + 1) * columns + c

		if wrap:
			if c == 0:
				left_i = r * columns + min(columns - 1, total - 1 - r * columns)
			if c == columns - 1 or right_i >= total:
				right_i = r * columns
			if r == 0:
				up_i = (rows - 1) * columns + c
			if down_i >= total:
				down_i = c

		btn.focus_neighbor_left = _safe_focus_path(btns, left_i, i)
		btn.focus_neighbor_right = _safe_focus_path(btns, right_i, i)
		btn.focus_neighbor_top = _safe_focus_path(btns, up_i, i)
		btn.focus_neighbor_bottom = _safe_focus_path(btns, down_i, i)


func _set_question_phase(new_phase: int) -> void:
	question_phase = new_phase


func _show_question_text(show: bool) -> void:
	_safe_set_visible(active_question_container, show)
	_safe_set_visible(active_question_text_label, show)
	# Only show category/value on the standard question UI
	if using_wager_question_ui:
		_safe_set_visible(q_category_label, false)
		_safe_set_visible(q_value_label, false)
	else:
		_safe_set_visible(q_category_label, true)
		_safe_set_visible(q_value_label, true)


func _clear_selected_choice() -> void:
	if active_selected_choice_label:
		active_selected_choice_label.text = ""
	_safe_set_visible(active_selected_choice_container, false)


func _show_selected_choice(choice_text: String) -> void:
	var text := str(choice_text)
	if active_selected_choice_label:
		active_selected_choice_label.text = text
	_safe_set_visible(active_selected_choice_container, text != "")


func _initialize_answer_buttons() -> void:
	answer_button_nodes.clear()
	var buttons := [answer_choice1, answer_choice2, answer_choice3, answer_choice4]
	for btn in buttons:
		if btn and is_instance_valid(btn):
			answer_button_nodes.append(btn)
			btn.focus_mode = Control.FOCUS_ALL
			btn.mouse_filter = Control.MOUSE_FILTER_STOP
			btn.disabled = true
			btn.set_meta("answer_text", "")
			var callable := Callable(self, "_on_answer_button_pressed").bind(btn)
			if not btn.pressed.is_connected(callable):
				btn.pressed.connect(callable)
	_wire_focus_grid(answer_button_nodes, 2)
	_clear_selected_choice()


func _initialize_wager_answer_buttons() -> void:
	wager_answer_button_nodes.clear()
	var buttons := [wager_answer_choice1, wager_answer_choice2, wager_answer_choice3, wager_answer_choice4]
	for btn in buttons:
		if btn and is_instance_valid(btn):
			wager_answer_button_nodes.append(btn)
			btn.focus_mode = Control.FOCUS_ALL
			btn.mouse_filter = Control.MOUSE_FILTER_STOP
			btn.disabled = true
			btn.set_meta("answer_text", "")
			var callable := Callable(self, "_on_answer_button_pressed").bind(btn)
			if not btn.pressed.is_connected(callable):
				btn.pressed.connect(callable)
	_wire_focus_grid(wager_answer_button_nodes, 2)
	_clear_selected_choice()


func _use_regular_question_ui() -> void:
	using_wager_question_ui = false
	if answer_button_nodes.is_empty():
		_initialize_answer_buttons()
	active_question_text_label = q_text_label
	active_result_label = result_label
	active_question_container = question_container
	active_result_container = result_container
	active_answer_container = answer_container
	active_answer_buttons_parent = answer_buttons
	active_selected_choice_label = selected_choice_label
	active_selected_choice_container = selected_choice_container
	active_answer_button_nodes = answer_button_nodes
	active_timer_label = answer_timer_label
	_clear_selected_choice()


func _use_wager_question_ui() -> void:
	using_wager_question_ui = true
	if wager_answer_button_nodes.is_empty():
		_initialize_wager_answer_buttons()
	active_question_text_label = wager_q_text_label
	active_result_label = wager_result_label
	active_question_container = wager_question_container
	active_result_container = wager_result_container
	active_answer_container = wager_answer_container
	active_answer_buttons_parent = wager_answer_buttons_parent
	active_selected_choice_label = wager_selected_choice_label
	active_selected_choice_container = wager_selected_choice_container
	active_answer_button_nodes = wager_answer_button_nodes
	active_timer_label = wager_timer_label
	_clear_selected_choice()


func _on_answer_button_pressed(button: Button) -> void:
	if button == null or not is_instance_valid(button):
		return
	var answer_text := str(button.get_meta("answer_text", ""))
	if answer_text == "" and button.text != "":
		answer_text = button.text
	_on_answer_selected(answer_text)


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
	game_state_machine = GameStateMachine.new()
	game_state_machine.state_changed.connect(_on_game_state_changed)
	if show_state_debug:
		_create_state_debug_label()
	main_menu_screen = MainMenuScreen.new(
		title_panel,
		settings_panel,
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
		pause_title_label,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		language_option,
		music_slider,
		answer_timer_label,
		question_panel,
		verse_data,
		func(en_text: String, pt_text: String) -> String: return _t(en_text, pt_text)
	)
	settings_screen = SettingsScreen.new(title_panel, settings_panel, pause_menu, question_panel)

	if question_panel:
		question_panel.visibility_changed.connect(_on_question_panel_visibility_changed)

	_use_regular_question_ui()
	_initialize_answer_buttons()
	_initialize_wager_answer_buttons()
	_collect_player_cards()
	_update_verse_of_day()
	# Hook up UI
	_safe_connect_pressed(title_play_button, _on_play_pressed, "Play button")
	_safe_connect_pressed(title_settings_button, _on_settings_pressed, "Settings button")
	_safe_connect_pressed(settings_back_button, _on_settings_back_pressed, "Settings back button")
	_safe_connect_value_changed(music_slider, _on_music_slider_changed, "Music slider")
	if music_slider and is_instance_valid(music_slider):
		music_slider.min_value = 0.0
		music_slider.max_value = 1.0
		music_slider.step = 0.01
		if not music_slider.drag_ended.is_connected(_on_music_slider_drag_ended):
			music_slider.drag_ended.connect(_on_music_slider_drag_ended)
	_safe_connect_item_selected(language_option, _on_language_selected, "Language option")
	_safe_connect_pressed(pause_resume_button, _on_pause_resume_pressed, "Pause resume button")
	_safe_connect_pressed(pause_main_menu_button, _on_pause_main_menu_pressed, "Pause main button")
	_safe_connect_pressed(
		pause_settings_button, _on_pause_settings_pressed, "Pause settings button"
	)
	_safe_connect_pressed(settings_exit_button, _on_exit_pressed, "Settings exit button")
	_safe_connect_pressed(
		controller_continue_button,
		_on_controller_connect_confirm_pressed,
		"Controller continue button"
	)
	_safe_connect_pressed(
		controller_back_button, _on_controller_connect_cancel_pressed, "Controller back button"
	)
	_safe_connect_pressed(
		board_settings_button, _on_board_settings_pressed, "Board settings button"
	)
	_connect_wager_buttons()
	_safe_connect_item_selected(
		controller_ai_option, func(idx: int) -> void: _on_ai_difficulty_selected(idx), "AI option"
	)
	if game_board:
		if game_board is Control:
			(game_board as Control).focus_mode = Control.FOCUS_ALL
		if not game_board.tile_pressed.is_connected(_on_game_board_tile_pressed):
			game_board.tile_pressed.connect(_on_game_board_tile_pressed)
		if not game_board.round_complete.is_connected(_on_game_board_round_complete):
			game_board.round_complete.connect(_on_game_board_round_complete)

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
	set_process(true)
	audio_controller.configure_streams(
		MUSIC_BACKGROUND, MUSIC_QUESTION, SFX_CORRECT, SFX_WRONG, SFX_SELECT
	)
	audio_controller.play_background_music()
	_cache_music_amplify()
	_populate_languages()
	_load_settings()
	_apply_language_texts()
	_setup_accessible_text()
	_safe_set_visible(active_timer_label, false)
	_safe_set_visible(wager_panel, false)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_container, false)
	_safe_set_visible(wager_hbox_player_container, false)
	_safe_set_visible(wager_timer_label, false)
	_safe_set_visible(wager_spacer_panel, false)
	_safe_set_visible(final_results_panel, false)
	_apply_theme_styles()
	_reset_round_state(0)
	if game_state_machine:
		game_state_machine.bootstrap(GameStateMachine.State.MAIN_MENU)


func _cache_music_amplify() -> void:
	music_bus_idx = AudioServer.get_bus_index(MUSIC_BUS)
	music_amp_effect_idx = -1
	music_amp = null

	if music_bus_idx < 0:
		push_warning("Bus '%s' not found." % MUSIC_BUS)
		return

	for i in range(AudioServer.get_bus_effect_count(music_bus_idx)):
		var eff: AudioEffect = AudioServer.get_bus_effect(music_bus_idx, i)
		if eff is AudioEffectAmplify:
			music_amp_effect_idx = i
			music_amp = eff as AudioEffectAmplify
			break

	if music_amp == null:
		push_warning(
			"No AudioEffectAmplify found on bus '%s'. Add it in the Audio Bus Layout." % MUSIC_BUS
		)


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


func _apply_language_texts() -> void:
	LoadedBibleData.set_language(current_language)
	FinalJeopardyData.set_language(current_language)
	if main_menu_screen:
		main_menu_screen.apply_language_texts(
			current_language, func(lang: String) -> void: LoadedBibleData.set_language(lang)
		)
	_apply_controller_connect_text()
	_update_verse_of_day()


func _setup_accessible_text() -> void:
	if verse_text_label:
		verse_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		verse_text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_reference_label:
		verse_reference_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_title_label:
		verse_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _show_game_board(show: bool) -> void:
	_safe_set_visible(game_board, show)
	if show and nav_focus_enabled and game_board:
		if game_board.has_method("focus_first_available_tile"):
			game_board.call("focus_first_available_tile")
		elif game_board is Control:
			(game_board as Control).grab_focus()


func _set_game_board_interactive(enabled: bool) -> void:
	if game_board:
		game_board.set_tiles_enabled(enabled)


func _sync_game_board_players() -> void:
	if game_board == null:
		_sync_question_panel_players()
		return
	var enriched: Array = []
	for i in range(players.size()):
		var p: Dictionary = players[i].duplicate(true)
		p["name"] = _player_name_for_ui(i)
		p["is_ai"] = bool(players[i].get("is_ai", false))
		p["score"] = _player_score_for_ui(i)
		enriched.append(p)
	game_board.set_players(enriched)
	_sync_question_panel_players()
	_update_player_portrait_highlight(current_turn_team)


func _update_game_board_score(idx: int) -> void:
	var score: int = team_scores[idx] if team_scores.size() > idx else 0
	_sync_session_state_score(idx)
	if game_board:
		game_board.update_player_score(idx, score)
	_update_question_panel_score(idx, score)
	_update_player_portrait_highlight(current_turn_team)


func _refresh_all_score_views() -> void:
	for i in range(min(players.size(), question_player_score_labels.size())):
		_update_question_panel_score(i, _player_score_for_ui(i))

	if game_board:
		for i in range(players.size()):
			game_board.update_player_score(i, _player_score_for_ui(i))

	if wager_panel and wager_panel.visible:
		_sync_wager_ui()

	if final_results_panel and final_results_panel.visible:
		_sync_final_results_cards_fixed_order()


func _format_score_text(score: int) -> String:
	var abs_value: int = abs(score)
	var prefix := "$" if score >= 0 else "-$"
	return "%s%d" % [prefix, abs_value]


func _update_question_panel_score(idx: int, score: int) -> void:
	if idx < 0 or idx >= question_player_score_labels.size():
		return
	var lbl: Label = question_player_score_labels[idx]
	if lbl:
		lbl.text = _format_score_text(score)


func _sync_question_panel_players() -> void:
	for i in range(question_player_name_labels.size()):
		var name_lbl: Label = question_player_name_labels[i]
		if name_lbl:
			name_lbl.text = _player_name_for_ui(i)
		_update_question_panel_score(i, _player_score_for_ui(i))
	_update_player_portrait_highlight(current_turn_team)


func _sync_wager_top_cards() -> void:
	for i in range(3):
		var has_player := i < players.size()
		var name_lbl := wager_top_name_labels[i] if i < wager_top_name_labels.size() else null
		var score_lbl := wager_top_score_labels[i] if i < wager_top_score_labels.size() else null
		if name_lbl:
			name_lbl.visible = has_player
			if has_player:
				name_lbl.text = _display_player_name_for_ui(i)
		if score_lbl:
			score_lbl.visible = has_player
			if has_player:
				var sc := team_scores[i] if i < team_scores.size() else 0
				score_lbl.text = _format_score_text(sc)


func _sync_wager_ui() -> void:
	if wager_panel == null or not is_instance_valid(wager_panel):
		return

	_sync_wager_top_cards()

	# Wager selection cards (name + wager amount).
	_ensure_wager_arrays()
	for i in range(wager_player_name_labels.size()):
		var has_player := i < players.size()
		var name_lbl: Label = wager_player_name_labels[i]
		var amt_lbl: Label = wager_amount_labels[i] if i < wager_amount_labels.size() else null

		if name_lbl:
			name_lbl.visible = has_player
			if has_player:
				name_lbl.text = _player_name_for_ui(i)

		if amt_lbl:
			amt_lbl.visible = has_player
			if has_player:
				var wager: int = final_wager_values[i] if i < final_wager_values.size() else 0
				var max_wager: int = abs(_player_score_for_ui(i))
				if final_wager_done.size() > i and final_wager_done[i]:
					amt_lbl.text = _t("Wager: $%d", "Aposta: $%d") % wager
				else:
					amt_lbl.text = _t("Wager: $0 (of $%d)", "Aposta: $0 (de $%d)") % max_wager


func _placement_text(idx: int) -> String:
	match idx:
		0:
			return _t("1st", "1o")
		1:
			return _t("2nd", "2o")
		2:
			return _t("3rd", "3o")
		_:
			return ""


func _labels_all_valid(arr: Array) -> bool:
	for n in arr:
		if n == null or not is_instance_valid(n):
			return false
	return true


func _wire_final_results_ui() -> void:
	if final_results_panel == null or not is_instance_valid(final_results_panel):
		push_warning("FinalResultsPanel missing.")
		return

	final_results_name_labels = [
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label"
		),
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label"
		),
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label"
		)
	]

	final_results_score_labels = [
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label2"
		),
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label2"
		),
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label2"
		)
	]

	final_results_place_labels = [
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/Placement"
		),
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/Placement"
		),
		final_results_panel.get_node_or_null(
			"Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/Placement"
		)
	]

	for i in range(3):
		if final_results_name_labels[i] == null:
			push_error("FinalResults name label missing for slot %d" % i)
		if final_results_score_labels[i] == null:
			push_error("FinalResults score label missing for slot %d" % i)
		if final_results_place_labels[i] == null:
			push_error("FinalResults place label missing for slot %d" % i)


func _sync_final_results_cards_fixed_order() -> void:
	if (
		not _labels_all_valid(final_results_name_labels)
		or not _labels_all_valid(final_results_score_labels)
		or not _labels_all_valid(final_results_place_labels)
	):
		_wire_final_results_ui()

	# Build a distinct, descending score list so ties share the same rank.
	var all_scores: Array[int] = []
	for i in range(players.size()):
		all_scores.append(_player_score_for_ui(i))
	var distinct_scores: Array[int] = []
	var sorted_scores := all_scores.duplicate()
	sorted_scores.sort() # ascending
	sorted_scores.reverse()
	for s in sorted_scores:
		if not distinct_scores.has(s):
			distinct_scores.append(s)

	for i in range(3):
		var has_player := i < players.size()
		var name_lbl := final_results_name_labels[i] if i < final_results_name_labels.size() else null
		var score_lbl := final_results_score_labels[i] if i < final_results_score_labels.size() else null
		var place_lbl := final_results_place_labels[i] if i < final_results_place_labels.size() else null

		if name_lbl:
			name_lbl.visible = has_player
			if has_player:
				name_lbl.text = _player_name_for_ui(i)

		if score_lbl:
			score_lbl.visible = has_player
			if has_player:
				score_lbl.text = _format_score_text(_player_score_for_ui(i))

		if place_lbl:
			place_lbl.visible = has_player
			if has_player:
				var score_i := _player_score_for_ui(i)
				var rank := distinct_scores.find(score_i)
				place_lbl.text = _placement_text(rank)


func _trim_category_for_round(cat: Dictionary) -> Dictionary:
	var copy := cat.duplicate(true)
	var values: Array = copy.get("values", [])
	var trimmed: Array = []
	var round_idx: int = clamp(round_index, 0, ROUND_VALUES.size() - 1)
	var round_values: Array = ROUND_VALUES[round_idx] as Array
	for row in range(BOARD_TILE_ROWS):
		if row >= values.size():
			break
		var val_entry := (values[row] as Dictionary).duplicate(true)
		if round_values.size() > row:
			val_entry["value"] = round_values[row]
		trimmed.append(val_entry)
	copy["values"] = trimmed
	return copy


func _bind_round_to_board(refresh_categories: bool = true) -> void:
	if game_board == null:
		return
	if refresh_categories or current_categories.is_empty():
		var all_cats: Array = LoadedBibleData.get_categories()
		current_categories.clear()
		var cat_count: int = min(BOARD_CATEGORY_COUNT, all_cats.size())
		for i in range(cat_count):
			var entry: Variant = all_cats[i]
			if typeof(entry) == TYPE_DICTIONARY:
				current_categories.append(_trim_category_for_round(entry as Dictionary))
			else:
				current_categories.append({"name": str(entry), "values": []})
	_select_hidden_double(current_categories.size(), BOARD_TILE_ROWS)
	total_clues_this_round = current_categories.size() * BOARD_TILE_ROWS
	game_board.bind_round(current_categories)
	if result_label:
		result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if main_menu_screen:
		main_menu_screen.setup_accessible_text()


func _create_state_debug_label() -> void:
	state_debug_label = Label.new()
	state_debug_label.name = "StateDebugLabel"
	add_child(state_debug_label)
	state_debug_label.set_anchors_preset(Control.PRESET_TOP_LEFT)
	state_debug_label.position = Vector2(12, 12)
	state_debug_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if theme_styler:
		theme_styler.apply_font_override(state_debug_label, game_font)
		theme_styler.apply_body_color(state_debug_label)
	state_debug_label.add_theme_font_size_override("font_size", 16)
	state_debug_label.text = "State: --"


func _update_state_debug_label(name: String) -> void:
	if state_debug_label:
		state_debug_label.text = "State: %s" % name


func _is_round_play_state() -> bool:
	if game_state_machine == null:
		return false
	return game_state_machine.is_in_any(
		[GameStateMachine.State.ROUND_1, GameStateMachine.State.ROUND_2]
	)


func _is_final_wager_state() -> bool:
	return (
		game_state_machine != null
		and game_state_machine.is_in_state(GameStateMachine.State.FINAL_JEOPARDY_WAGER)
	)


func _is_final_question_state() -> bool:
	return (
		game_state_machine != null
		and game_state_machine.is_in_state(GameStateMachine.State.FINAL_JEOPARDY_QUESTION)
	)


func _is_results_state() -> bool:
	return (
		game_state_machine != null
		and game_state_machine.is_in_state(GameStateMachine.State.RESULTS)
	)


func _is_final_phase() -> bool:
	return _is_final_wager_state() or _is_final_question_state()


func _on_game_state_changed(old_state: int, new_state: int, payload: Dictionary = {}) -> void:
	var from_name := game_state_machine.name_for(old_state) if game_state_machine else "UNKNOWN"
	var to_name := game_state_machine.name_for(new_state) if game_state_machine else "UNKNOWN"
	print("Game state: %s -> %s" % [from_name, to_name])
	_update_state_debug_label(to_name)
	if old_state != new_state:
		_handle_state_exit(old_state, new_state)
	if (
		old_state == GameStateMachine.State.PAUSED
		and game_state_machine
		and new_state == game_state_machine.paused_from_state
	):
		_maybe_focus_for_nav()
		return
	_handle_state_enter(new_state, payload)


func _handle_state_exit(state: int, _next: int) -> void:
	match state:
		GameStateMachine.State.PAUSED:
			_close_pause_menu()
			_resume_answer_timer_if_needed()
		GameStateMachine.State.RESULTS:
			_cancel_final_results_timer()
		_:
			pass


func _handle_state_enter(state: int, payload: Dictionary = {}) -> void:
	match state:
		GameStateMachine.State.MAIN_MENU:
			_enter_main_menu_state()
		GameStateMachine.State.CONTROLLER_SETUP:
			_enter_controller_setup_state()
		GameStateMachine.State.ROUND_1:
			_enter_round_one_state(payload)
		GameStateMachine.State.ROUND_1_TO_2_TRANSITION:
			_enter_round_two_transition_state()
		GameStateMachine.State.ROUND_2:
			_enter_round_two_state()
		GameStateMachine.State.FINAL_JEOPARDY_WAGER:
			_enter_final_wager_state()
		GameStateMachine.State.FINAL_JEOPARDY_QUESTION:
			_enter_final_question_state()
		GameStateMachine.State.RESULTS:
			_enter_results_state()
		GameStateMachine.State.PAUSED:
			_enter_pause_state()
		_:
			pass


func _enter_main_menu_state() -> void:
	_restart_to_main_menu()


func _enter_controller_setup_state() -> void:
	_open_controller_connect(join_inputs)


func _enter_round_one_state(payload: Dictionary = {}) -> void:
	_reset_round_state(0)
	if payload.has("allow_keyboard_fallback"):
		pending_allow_keyboard_fallback = bool(payload["allow_keyboard_fallback"])
	_start_game(pending_player_inputs, pending_allow_keyboard_fallback)
	pending_player_inputs.clear()
	pending_allow_keyboard_fallback = true


func _enter_round_two_transition_state() -> void:
	_show_result(_t("Round %d!", "Rodada %d!") % 2, Color(0.6, 0.8, 1.0))
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.ROUND_2)
	else:
		_reset_round_state(1, false)


func _enter_round_two_state() -> void:
	_reset_round_state(1, true, true)
	_bind_round_to_board(true)
	_show_game_board(true)
	_sync_game_board_players()


func _enter_final_wager_state() -> void:
	_hide_question_ui_for_wager()
	_start_final_round()
	_sync_wager_ui()


func _enter_final_question_state() -> void:
	_use_wager_question_ui()
	if not final_question_revealed:
		_reveal_final_question()
	else:
		_safe_set_visible(question_panel, false)
		_safe_set_visible(wager_panel, true)
		_safe_set_visible(wager_question_panel, true)
		_safe_set_visible(wager_container, false)
		_safe_set_visible(wager_hbox_player_container, true)
		_safe_set_visible(wager_spacer_panel, false)
		_safe_set_visible(wager_timer_container, true)
		_safe_set_visible(wager_category_label, false)
		_safe_set_visible(wager_category_panel, false)


func _enter_results_state() -> void:
	_cancel_final_results_timer()
	_hide_all_views()
	_wire_final_results_ui()
	if q_category_label:
		q_category_label.text = _t("Final Results", "Resultados finais")
	if q_value_label:
		q_value_label.text = ""
	_safe_set_visible(q_value_label, false)
	q_text_label.text = ""
	_show_results_view()
	_sync_final_results_cards_fixed_order()
	_show_winner_trophies()
	if final_results_duration_seconds > 0.0:
		final_results_timer = get_tree().create_timer(final_results_duration_seconds)
		final_results_timer.timeout.connect(_on_final_results_timeout)


func _enter_pause_state() -> void:
	_pause_answer_timer()
	_open_pause_menu()


func _apply_controller_connect_text() -> void:
	if controller_title_label:
		controller_title_label.text = _t("Connect Controllers", "Conectar controles")
	if controller_subtitle_label:
		controller_subtitle_label.text = _t(
			"Press any button to claim Players 1-3. Remaining slots become AI.",
			"Aperte qualquer botao para assumir Jogadores 1-3. Vagas restantes viram IA."
		)
	if controller_difficulty_label:
		controller_difficulty_label.text = _t("Difficulty:", "Dificuldade:")
		controller_difficulty_label.add_theme_font_size_override("font_size", 16)
	if controller_ai_label:
		controller_ai_label.text = _t("Difficulty:", "Dificuldade:")
		controller_ai_label.add_theme_font_size_override("font_size", 16)
	if _safe_clear_option(controller_ai_option, "Controller AI option"):
		controller_ai_option.add_item(_t("Easy", "Facil"), 0)
		controller_ai_option.add_item(_t("Normal", "Normal"), 1)
		controller_ai_option.add_item(_t("Hard", "Dificil"), 2)
		controller_ai_option.select(1)
	if controller_ai_option:
		controller_ai_option.add_theme_font_size_override("font_size", 16)
	_set_button_label_text(controller_continue_button, _t("Continue", "Continuar"))
	_set_button_label_text(controller_back_button, _t("Back", "Voltar"))
	_refresh_controller_join_ui()


func _apply_theme_styles() -> void:
	if theme_styler == null:
		return

	var font_controls: Array[Control] = [
		verse_title_label,
		verse_text_label,
		verse_reference_label,
		title_screen_title,
		settings_language_label,
		music_label,
		pause_title_label,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		language_option,
		controller_status_label,
		controller_slot_labels[0] if controller_slot_labels.size() > 0 else null,
		controller_slot_labels[1] if controller_slot_labels.size() > 1 else null,
		controller_slot_labels[2] if controller_slot_labels.size() > 2 else null,
	]
	theme_styler.apply_game_font(game_font, font_controls)

	var primary_controls: Array = [
		verse_title_label,
		verse_text_label,
		verse_reference_label,
		settings_language_label,
		music_label,
		pause_title_label,
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button,
		language_option,
		music_slider,
		controller_status_label,
		controller_slot_labels[0] if controller_slot_labels.size() > 0 else null,
		controller_slot_labels[1] if controller_slot_labels.size() > 1 else null,
		controller_slot_labels[2] if controller_slot_labels.size() > 2 else null,
		controller_ai_label,
		controller_ai_option
	]

	var button_controls := [
		pause_resume_button,
		pause_main_menu_button,
		pause_settings_button
	]

	var pause_panel := (
		pause_menu.get_node("Panel") if pause_menu and pause_menu.has_node("Panel") else null
	)
	question_panel_base_style = theme_styler.apply_bible_theme(
		title_screen_title,
		primary_controls,
		settings_language_label,
		music_label,
		null,
		null,
		pause_panel,
		button_controls,
		game_font,
		null,
		int(round(reading_timer_seconds))
	)
	if verse_title_label:
		verse_title_label.add_theme_font_size_override("font_size", 20)
	if verse_reference_label:
		verse_reference_label.add_theme_font_size_override("font_size", 20)
		verse_reference_label.add_theme_color_override("font_color", theme_styler.theme_body_color)
		verse_reference_label.add_theme_font_override("font", game_font)
	if verse_reference_label:
		verse_reference_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if verse_text_label:
		verse_text_label.add_theme_font_size_override("font_size", 18)
		verse_text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		verse_text_label.add_theme_color_override("font_color", theme_styler.theme_body_color)

	if controller_connect_content and question_panel_base_style:
		controller_connect_content.add_theme_stylebox_override(
			"panel", question_panel_base_style.duplicate()
		)
	_refresh_controller_join_ui()


func _connect_wager_buttons() -> void:
	for i in range(wager_choice_buttons.size()):
		var row: Array = wager_choice_buttons[i]
		if row.size() < 3:
			continue
		var idx := i
		_connect_wager_button(row[0], idx, 0.3, "WagerChoice 30% idx=%d" % idx)
		_connect_wager_button(row[1], idx, 0.5, "WagerChoice 50% idx=%d" % idx)
		_connect_wager_button(row[2], idx, 1.0, "WagerChoice 100% idx=%d" % idx)


func _connect_wager_button(btn: BaseButton, idx: int, pct: float, label: String) -> void:
	if btn == null or not is_instance_valid(btn):
		push_warning("%s missing; cannot connect" % label)
		return
	var cb := Callable(self, "_on_wager_choice").bind(idx, pct)
	if not btn.pressed.is_connected(cb):
		btn.pressed.connect(cb)


func _stop_team_card_pulse() -> void:
	if team_card_pulse_tween and is_instance_valid(team_card_pulse_tween):
		if team_card_pulse_tween.is_running():
			team_card_pulse_tween.stop()
		team_card_pulse_tween.kill()
	team_card_pulse_tween = null
	for c in team_cards:
		if c and is_instance_valid(c):
			(c as Control).custom_minimum_size = Vector2.ZERO
			(c as Control).modulate = Color(1, 1, 1, 1)


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
	tween.set_loops() # Continuous pulse
	tween.tween_property(card, "scale", Vector2.ONE * 1.04, 0.45)
	tween.tween_property(card, "scale", Vector2.ONE, 0.45)
	team_card_pulse_tween = tween


func _update_player_portrait_highlight(active_idx: int) -> void:
	# How many player slots you actually have:
	var player_count: int = min(3, players.size())

	for player_idx in range(player_count):
		var is_active := player_idx == active_idx and active_idx >= 0
		var factor := active_player_scale if is_active else 1.0
		var target_alpha := 1.0 if is_active else inactive_player_opacity

		# Board card
		if player_idx < board_player_panels.size():
			var bcard := board_player_panels[player_idx] as Control
			if bcard and is_instance_valid(bcard):
				var base := (
					base_board_sizes[player_idx]
					if player_idx < base_board_sizes.size()
					else bcard.custom_minimum_size
				)
				bcard.custom_minimum_size = base * factor

				var c := bcard.modulate
				c.a = target_alpha
				bcard.modulate = c

				var b_inner := bcard.get_node_or_null("VBoxContainer/Control") as Control
				if b_inner and is_instance_valid(b_inner):
					var inner_size := b_inner.custom_minimum_size
					var base_inner_h := (
						base_board_inner_heights[player_idx]
						if player_idx < base_board_inner_heights.size()
						else inner_size.y
					)
					inner_size.y = 120.0 if is_active else base_inner_h
					b_inner.custom_minimum_size = inner_size

		# Question card
		if player_idx < question_player_panels.size():
			var qcard := question_player_panels[player_idx] as Control
			if qcard and is_instance_valid(qcard):
				var baseq := (
					base_question_sizes[player_idx]
					if player_idx < base_question_sizes.size()
					else qcard.custom_minimum_size
				)
				qcard.custom_minimum_size = baseq * factor

				var cq := qcard.modulate
				cq.a = target_alpha
				qcard.modulate = cq

				var q_inner := qcard.get_node_or_null("VBoxContainer/Control") as Control
				if q_inner and is_instance_valid(q_inner):
					var innerq_size := q_inner.custom_minimum_size
					var base_inner_hq := (
						base_question_inner_heights[player_idx]
						if player_idx < base_question_inner_heights.size()
						else innerq_size.y
					)
					innerq_size.y = 120.0 if is_active else base_inner_hq
					q_inner.custom_minimum_size = innerq_size

		print_debug(
			(
				"Highlight player=%d active=%s factor=%.2f alpha=%.2f"
				% [player_idx, str(is_active), factor, target_alpha]
			)
		)


func _set_active_team(idx: int) -> void:
	var max_team: int = max(0, players.size() - 1)
	current_turn_team = clamp(idx, 0, max_team)
	if theme_styler:
		theme_styler.refresh_team_highlight(team_cards, current_turn_team)
	_update_player_portrait_highlight(current_turn_team)


func _reset_question_panel_color() -> void:
	# Visual styling is controlled in the editor; nothing to reset in code.
	pass


func _show_results_view() -> void:
	_safe_set_visible(question_panel, false)
	_safe_set_visible(question_header_container, false)
	_safe_set_visible(result_container, false)
	_safe_set_visible(question_container, false)
	_safe_set_visible(answer_container, false)
	_safe_set_visible(selected_choice_container, false)
	_safe_set_visible(answer_buttons, false)
	_safe_set_visible(active_timer_label, false)
	_safe_set_visible(wager_timer_label, false)
	_safe_set_visible(wager_panel, false)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_spacer_panel, false)
	_safe_set_visible(final_results_panel, true)


func _hide_all_views() -> void:
	_safe_set_visible(question_panel, false)
	_safe_set_visible(question_header_container, false)
	_safe_set_visible(question_container, false)
	_safe_set_visible(result_container, false)
	_safe_set_visible(answer_container, false)
	_safe_set_visible(answer_buttons, false)
	_safe_set_visible(selected_choice_container, false)
	_safe_set_visible(active_timer_label, false)
	_safe_set_visible(wager_timer_label, false)
	_safe_set_visible(wager_panel, false)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_spacer_panel, false)
	_safe_set_visible(game_board, false)
	_safe_set_visible(controller_connect_panel, false)
	_safe_set_visible(settings_panel, false)
	_safe_set_visible(title_panel, false)
	_safe_set_visible(final_results_panel, false)


func _hide_question_ui_for_wager() -> void:
	_safe_set_visible(question_panel, false)
	_safe_set_visible(question_header_container, false)
	_safe_set_visible(question_container, false)
	_safe_set_visible(result_container, false)
	_safe_set_visible(answer_container, false)
	_safe_set_visible(answer_buttons, false)
	_safe_set_visible(selected_choice_container, false)
	_safe_set_visible(active_timer_label, false)
	_safe_set_visible(wager_timer_label, false)
	_safe_set_visible(wager_timer_container, false)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_spacer_panel, false)
	if result_label:
		result_label.text = ""
	if wager_result_label:
		wager_result_label.text = ""
	if q_text_label:
		q_text_label.text = ""
	if wager_q_text_label:
		wager_q_text_label.text = ""


func _collect_player_cards() -> void:
	team_cards.clear()
	base_board_sizes.clear()
	base_question_sizes.clear()
	base_board_inner_heights.clear()
	base_question_inner_heights.clear()

	for i in range(3):
		# Board cards
		if i < board_player_panels.size():
			var board_card := board_player_panels[i] as Control
			if board_card and is_instance_valid(board_card):
				team_cards.append(board_card)
				base_board_sizes.append(board_card.custom_minimum_size)
				var b_inner := board_card.get_node_or_null("VBoxContainer/Control") as Control
				base_board_inner_heights.append(
					b_inner.custom_minimum_size.y if b_inner and is_instance_valid(b_inner) else 0.0
				)
			else:
				base_board_sizes.append(Vector2.ZERO)
				base_board_inner_heights.append(0.0)
		else:
			base_board_sizes.append(Vector2.ZERO)
			base_board_inner_heights.append(0.0)

		# Question cards
		if i < question_player_panels.size():
			var question_card := question_player_panels[i] as Control
			if question_card and is_instance_valid(question_card):
				team_cards.append(question_card)
				base_question_sizes.append(question_card.custom_minimum_size)
				var q_inner := question_card.get_node_or_null("VBoxContainer/Control") as Control
				base_question_inner_heights.append(
					q_inner.custom_minimum_size.y if q_inner and is_instance_valid(q_inner) else 0.0
				)
			else:
				base_question_sizes.append(Vector2.ZERO)
				base_question_inner_heights.append(0.0)
		else:
			base_question_sizes.append(Vector2.ZERO)
			base_question_inner_heights.append(0.0)

	_update_player_portrait_highlight(current_turn_team)


func _on_question_panel_visibility_changed() -> void:
	var showing := question_panel != null and question_panel.visible


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
	if main_menu_screen:
		main_menu_screen.show_title()
	_safe_set_visible(controller_connect_panel, false)
	_show_game_board(false)
	pending_player_inputs.clear()
	player_characters.clear()
	controller_join_active = false
	local_player_index = -1
	_close_pause_menu()
	if title_play_button and nav_focus_enabled:
		title_play_button.grab_focus()


func _on_play_pressed() -> void:
	_play_select_sfx()
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.CONTROLLER_SETUP)


func _on_settings_pressed() -> void:
	_play_select_sfx()
	settings_opened_from_pause = false
	if settings_screen:
		settings_screen.show_settings_from_title()
	if language_option and nav_focus_enabled:
		language_option.grab_focus()


func _on_board_settings_pressed() -> void:
	_play_select_sfx()
	if game_state_machine:
		game_state_machine.pause()
	else:
		_open_pause_menu()


func _on_settings_back_pressed() -> void:
	_play_select_sfx()
	if settings_opened_from_pause:
		settings_opened_from_pause = false
		if settings_screen:
			settings_screen.back_to_pause()
	else:
		if game_state_machine:
			game_state_machine.transition_to(GameStateMachine.State.MAIN_MENU, {}, true)


func _open_controller_connect(restore_inputs: Array = []) -> void:
	_safe_set_visible(title_panel, false)
	_safe_set_visible(settings_panel, false)
	_show_game_board(false)
	controller_join_active = true
	join_inputs = restore_inputs.duplicate(true)
	if controller_connect_panel == null:
		controller_join_active = false
		pending_player_inputs = join_inputs.duplicate(true)
		pending_allow_keyboard_fallback = true
		if game_state_machine:
			game_state_machine.transition_to(
				GameStateMachine.State.ROUND_1, {"allow_keyboard_fallback": true}
			)
		return
	_refresh_controller_join_ui()
	_safe_set_visible(controller_connect_panel, true)
	if controller_continue_button:
		controller_continue_button.disabled = false
		if nav_focus_enabled:
			controller_continue_button.grab_focus()
	_update_ai_difficulty_visibility()


func _close_controller_connect() -> void:
	controller_join_active = false
	_safe_set_visible(controller_connect_panel, false)


func _on_controller_connect_confirm_pressed() -> void:
	_play_select_sfx()
	var devices := join_inputs.duplicate()
	if devices.is_empty():
		_register_keyboard_join(false)
		devices = join_inputs.duplicate()
	_close_controller_connect()
	pending_player_inputs = devices.duplicate(true)
	pending_allow_keyboard_fallback = false
	if game_state_machine:
		game_state_machine.transition_to(
			GameStateMachine.State.ROUND_1, {"allow_keyboard_fallback": false}
		)
	else:
		_start_game(pending_player_inputs, false)


func _on_controller_connect_cancel_pressed() -> void:
	_play_select_sfx()
	join_inputs.clear()
	_close_controller_connect()
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.MAIN_MENU)


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


func _character_data_for(name: String) -> Dictionary:
	for c in CHARACTER_ROSTER:
		if str((c as Dictionary).get("name", "")).to_lower() == name.to_lower():
			return (c as Dictionary).duplicate(true)
	return {"name": name, "bg": Color(0.2, 0.2, 0.2), "accent": Color(0.3, 0.3, 0.3)}


func _available_character_names() -> Array[String]:
	var names: Array[String] = []
	for c in CHARACTER_ROSTER:
		var n := str((c as Dictionary).get("name", ""))
		if n == "":
			continue
		names.append(n)
	return names


func _auto_assign_default_characters() -> void:
	player_characters.clear()
	var available := _available_character_names()
	for i in range(players.size()):
		if available.is_empty():
			available = _available_character_names()
		if available.is_empty():
			player_characters.append({})
			continue
		var idx := rng.randi_range(0, available.size() - 1)
		var pick := available[idx]
		available.remove_at(idx)
		player_characters.append(_character_data_for(pick))


func _start_game(selected_inputs: Array = [], allow_keyboard_fallback: bool = true) -> void:
	_safe_set_visible(title_panel, false)
	_safe_set_visible(settings_panel, false)
	_safe_set_visible(controller_connect_panel, false)
	_safe_set_visible(wager_panel, false)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_container, false)
	_safe_set_visible(wager_hbox_player_container, false)
	_safe_set_visible(wager_timer_label, false)
	controller_join_active = false
	_reset_round_state()
	_setup_players(3, selected_inputs, allow_keyboard_fallback)
	_fix_single_controller_device_id()
	# Ensure character assignments match the current player count
	if player_characters.size() != players.size():
		player_characters.clear()
		_auto_assign_default_characters()
	_apply_player_characters()
	_sync_game_board_players()
	_bind_round_to_board(true)
	_show_game_board(true)
	_safe_set_visible(question_panel, false)


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
	for i in range(controller_slot_labels.size()):
		if controller_slot_labels[i]:
			controller_slot_labels[i].text = _t("Player %d", "Jogador %d") % (i + 1)
	for i in range(controller_slot_status_labels.size()):
		if controller_slot_status_labels[i]:
			controller_slot_status_labels[i].text = _controller_slot_status_text(i + 1)
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


func _controller_slot_status_text(slot_index: int) -> String:
	if slot_index - 1 < join_inputs.size():
		var entry := join_inputs[slot_index - 1]
		var type := str(entry.get("type", ""))
		if type == "keyboard":
			return _t("Keyboard", "Teclado")
		var dev_id := int(entry.get("device_id", -1))
		var joy_name := Input.get_joy_name(dev_id)
		if joy_name.strip_edges() == "":
			joy_name = _t("Controller", "Controle")
		return joy_name
	return _t("Press any button", "Aperte qualquer botao")


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

	if current_clue.is_empty():
		# When selecting tiles on the board or navigating menus, don't swallow input.
		# Focus/navigation needs to see controller/keyboard events.
		return


func _can_open_pause_menu() -> bool:
	var qp_visible := (
		question_panel and is_instance_valid(question_panel) and question_panel.visible
	)
	var gb_visible := game_board and is_instance_valid(game_board) and game_board.visible
	if controller_join_active:
		return false
	if title_panel and title_panel.visible:
		return false
	if settings_panel and settings_panel.visible:
		return false
	return qp_visible or gb_visible


func _open_pause_menu() -> void:
	nav_focus_enabled = true
	_safe_set_visible(settings_panel, false)
	_safe_set_visible(pause_menu, true)
	if pause_resume_button:
		pause_resume_button.grab_focus()
	_maybe_focus_for_nav()
	_pause_answer_timer()


func _close_pause_menu() -> void:
	_safe_set_visible(pause_menu, false)
	get_viewport().set_input_as_handled()


func _on_pause_resume_pressed() -> void:
	_play_select_sfx()
	if game_state_machine:
		game_state_machine.resume()
	else:
		_close_pause_menu()
		_resume_answer_timer_if_needed()
		_maybe_focus_for_nav()


func _on_pause_main_menu_pressed() -> void:
	_play_select_sfx()
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.MAIN_MENU)
	else:
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
	if not _safe_clear_option(language_option, "Language option"):
		return
	language_option.add_item("English", 0)
	language_option.add_item("Portuguese (BR)", 1)
	language_option.selected = 0


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_settings(true)


func _exit_tree() -> void:
	_save_settings(true)


func _load_settings() -> void:
	loading_settings = true
	var cfg := ConfigFile.new()
	var err := cfg.load(SETTINGS_PATH)
	var default_linear := 0.5 # Approximately 50% perceived volume
	if music_slider:
		music_slider.min_value = 0.0
		music_slider.max_value = 1.0
		default_linear = clamp(default_linear, music_slider.min_value, music_slider.max_value)
		if err != OK:
			music_slider.value = default_linear
			_on_music_slider_changed(music_slider.value)
	if err == OK:
		current_language = str(cfg.get_value("general", "language", current_language))
		var saved_raw: Variant = cfg.get_value("audio", "music_db", default_linear)
		var saved_linear: float = default_linear
		if typeof(saved_raw) == TYPE_FLOAT:
			var val := float(saved_raw)
			# Accept legacy dB values (< -1 or > 1) by converting them.
			if val >= 0.0 and val <= 1.0:
				saved_linear = val
			else:
				saved_linear = db_to_linear(val)
		if music_slider:
			music_slider.value = clamp(saved_linear, music_slider.min_value, music_slider.max_value)
			_on_music_slider_changed(music_slider.value)
		if language_option:
			language_option.select(1 if current_language == "pt" else 0)
		FinalJeopardyData.set_language(current_language)
	loading_settings = false
	settings_initialized = true


func _save_settings(force: bool = false) -> void:
	if loading_settings and not force:
		return
	if not settings_initialized and not force:
		return
	var cfg := ConfigFile.new()
	cfg.set_value("general", "language", current_language)
	var music_linear := 0.5
	if music_slider:
		music_linear = clamp(music_slider.value, music_slider.min_value, music_slider.max_value)
	cfg.set_value("audio", "music_db", music_linear)
	var err := cfg.save(SETTINGS_PATH)
	if err != OK:
		push_warning("Failed to save settings: %s" % str(err))


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


func _finalize_wager(idx: int, amount: int, reason_text: String = "") -> void:
	if idx < 0 or idx >= players.size():
		return
	if idx >= final_wager_values.size():
		return
	final_wager_values[idx] = amount
	final_wager_done[idx] = true
	_maybe_finish_wagers()


func _on_music_slider_changed(value: float) -> void:
	var linear_val := value
	if music_slider:
		linear_val = clamp(value, music_slider.min_value, music_slider.max_value)
	linear_val = clamp(linear_val, 0.0, 1.0)
	var db_value := linear_to_db(max(linear_val, 0.001))
	_set_music_amp_db(db_value)


func _on_music_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed:
		return
	_play_select_sfx()
	_save_settings()


func _set_music_amp_db(db_value: float) -> void:
	if music_amp != null:
		music_amp.volume_db = db_value
	elif music_bus_idx >= 0:
		# Fallback: adjust bus volume directly if no Amplify effect is present.
		AudioServer.set_bus_volume_db(music_bus_idx, db_value)


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

	team_scores.resize(players.size())
	for i in range(team_scores.size()):
		team_scores[i] = 0
	_sync_team_names_from_players()
	print("players=", players)
	print("current_turn_team=", current_turn_team)
	_sync_game_board_players()


func _fix_single_controller_device_id() -> void:
	var joypads := Input.get_connected_joypads()
	if joypads.size() != 1:
		return
	if players.is_empty():
		return
	if players[0].get("uses_keyboard", false):
		return
	var stored := int(players[0].get("device_id", -1))
	var actual := int(joypads[0])
	if stored != actual:
		players[0]["device_id"] = actual
		print("Fixed device_id:", stored, "->", actual)


func _sync_team_names_from_players() -> void:
	var names: Array[String] = []
	for i in range(players.size()):
		names.append(_player_name_for_ui(i))
	team_names = names
	_sync_session_state_players()


func _sync_session_state_players() -> void:
	GameSessionState.set_players(players, team_scores)


func _sync_session_state_score(idx: int) -> void:
	if idx < 0:
		return
	var score_val := team_scores[idx] if idx < team_scores.size() else 0
	GameSessionState.set_score(idx, score_val)


func _player_name_for_ui(idx: int) -> String:
	var fallback := "Player %d" % (idx + 1)
	if idx < 0 or idx >= players.size():
		return fallback
	var p: Dictionary = players[idx]
	var n := str(p.get("name", fallback))
	if p.get("is_ai", false) and "(AI)" not in n and "A.I." not in n:
		n = "%s (AI)" % n
	return n


func _player_score_for_ui(idx: int) -> int:
	if idx < 0:
		return 0
	if idx < team_scores.size():
		return int(team_scores[idx])
	return 0


func _player_card_data(idx: int) -> Dictionary:
	var name: String = _player_name_for_ui(idx)
	var score: int = _player_score_for_ui(idx)
	var is_ai: bool = (
		bool(players[idx].get("is_ai", false)) if idx >= 0 and idx < players.size() else false
	)
	return {"name": name, "score": score, "is_ai": is_ai}


func _display_player_name_for_ui(idx: int) -> String:
	return _player_name_for_ui(idx)


func _apply_player_characters() -> void:
	if player_characters.is_empty():
		return
	for i in range(min(players.size(), player_characters.size())):
		var char_data := player_characters[i]
		if typeof(char_data) != TYPE_DICTIONARY or char_data.is_empty():
			continue
		players[i]["character"] = char_data
		if not players[i].get("is_ai", false):
			var display_name := str(char_data.get("name", "Player %d" % (i + 1)))
			players[i]["name"] = display_name
	_sync_team_names_from_players()
	_sync_game_board_players()


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()


func _clear_trophies() -> void:
	for t in team_trophies:
		_safe_set_visible(t, false)


func _clear_wager_labels() -> void:
	for w in team_wager_labels:
		if w and is_instance_valid(w):
			_safe_set_visible(w, false)
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
			_safe_set_visible(trophy, true)
		var name := _player_name_for_ui(i)
		winners.append(name)
	if not winners.is_empty():
		_show_result(_t("Winner: %s", "Vencedor: %s") % ", ".join(winners), Color(0.2, 0.6, 0.2))


func _start_clue_for_indices(
	cat_index: int,
	clue_index: int,
	score_value_hint: int = -1,
	tile_idx: int = -1,
	button: Button = null
) -> void:
	if cat_index < 0 or clue_index < 0:
		return
	var key := "%d-%d" % [cat_index, clue_index]
	if answered_map.has(key):
		return # Already used

	_play_select_sfx()
	_reset_question_panel_color()

	_use_regular_question_ui()
	_show_result("")

	if cat_index >= current_categories.size():
		return
	var cat_data: Dictionary = current_categories[cat_index] as Dictionary
	var values: Array = cat_data.get("values", [])
	if clue_index >= values.size():
		return
	var value_entry: Dictionary = values[clue_index] as Dictionary
	var pool: Array = value_entry.get("pool", [])
	if pool.is_empty():
		return
	var random_index := rng.randi_range(0, pool.size() - 1)
	var clue: Dictionary = pool[random_index] as Dictionary
	pool.remove_at(random_index)
	var question_text := str(clue.get("question", ""))
	var score_value: int = (
		score_value_hint if score_value_hint >= 0 else int(value_entry.get("value", 0))
	)
	var is_double := hidden_double_key != "" and hidden_double_key == key
	if is_double:
		score_value *= 2
		_show_result(_t("Double points!", "Pontos em dobro!"), Color(0.9, 0.7, 0.1))
	else:
		_show_result("", Color(1, 1, 1))
	question_selector_team = current_turn_team
	current_wager = 0

	current_clue = {
		"cat_index": cat_index,
		"clue_index": clue_index,
		"tile_index": tile_idx,
		"value": score_value,
		"answer": clue.get("answer", ""),
		"is_double": is_double
	}
	if button:
		current_clue["button"] = button

	if q_category_label:
		q_category_label.text = _t("Category: %s", "Categoria: %s") % str(cat_data.get("name", ""))
	if q_value_label:
		q_value_label.text = _t("Value: %s", "Valor: %s") % str(score_value)
	q_text_label.text = ""
	current_options.clear()
	_cancel_ai_buzz_timer()
	buzzed_player = -1
	attempted_players.clear()

	_set_question_phase(QuestionPhase.READING)
	_safe_set_visible(question_panel, true)
	_safe_set_visible(wager_panel, false)
	_build_answer_options(clue)
	_begin_question_audio()
	_start_question_flow(question_text)
	_set_game_board_interactive(false)


func _on_clue_button_pressed(button: Button) -> void:
	if button == null:
		return
	var cat_index: int = int(button.get_meta("cat_index"))
	var clue_index: int = int(button.get_meta("clue_index"))
	var score_value: int = int(button.get_meta("score_value", -1))
	await _start_clue_for_indices(cat_index, clue_index, score_value, -1, button)


func _on_game_board_tile_pressed(tile_state: Dictionary, tile_idx: int) -> void:
	var cat_index: int = int(tile_state.get("category_index", -1))
	var clue_index: int = int(tile_state.get("value_index", -1))
	var score_value: int = int(tile_state.get("value", -1))
	if tile_state.get("answered", false):
		return
	await _start_clue_for_indices(cat_index, clue_index, score_value, tile_idx, null)


func _on_game_board_round_complete() -> void:
	_advance_round_if_needed()


func _start_question_flow(question_text: String) -> void:
	_show_question_text(true)
	_safe_set_visible(active_answer_container, false)
	_safe_set_visible(active_answer_buttons_parent, false)
	_safe_set_visible(active_selected_choice_container, false)
	_safe_set_visible(active_result_container, false)
	if not using_wager_question_ui:
		_safe_set_visible(wager_question_panel, false)
	_show_result("", Color(0.1, 0.1, 0.1))
	_type_out_question(question_text)
	if _is_final_phase():
		if _is_final_wager_state():
			return
		if final_question_revealed:
			return
	_start_answer_timer(reading_timer_seconds)


func _type_out_question(text: String) -> void:
	is_typing_question = true
	if active_question_text_label:
		active_question_text_label.text = ""
	var length := text.length()
	if length == 0:
		_on_question_typed_out()
		return
	# Iterate characters with a lightweight loop
	for i in range(length):
		if active_question_text_label:
			active_question_text_label.text += text[i]
		await get_tree().create_timer(QUESTION_CHAR_DELAY).timeout
	is_typing_question = false
	_on_question_typed_out()


func _on_question_typed_out() -> void:
	_start_ai_buzz_timer()


func _build_answer_options(clue: Dictionary) -> void:
	_clear_selected_choice()
	_safe_set_visible(active_result_container, false)
	_show_question_text(true)
	var correct_answer: String = str(clue.get("answer", ""))

	var decoys: Array[String] = []
	if clue.has("decoys"):
		for d in clue["decoys"] as Array:
			decoys.append(str(d))
	if decoys.size() > 3:
		decoys.resize(3)

	var options: Array[String] = [correct_answer]
	options.append_array(decoys)
	options.shuffle() # 4 options total

	current_options.clear()
	for opt in options:
		current_options.append(str(opt))

	if using_wager_question_ui:
		if wager_answer_button_nodes.is_empty():
			_initialize_wager_answer_buttons()
		active_answer_button_nodes = wager_answer_button_nodes
	else:
		if answer_button_nodes.is_empty():
			_initialize_answer_buttons()
		active_answer_button_nodes = answer_button_nodes

	for i in range(active_answer_button_nodes.size()):
		var btn := active_answer_button_nodes[i]
		if btn == null or not is_instance_valid(btn):
			continue
		var has_option := i < options.size()
		var opt_text := options[i] if has_option else ""
		btn.disabled = false
		btn.set_meta("answer_text", opt_text)
		_set_button_label_text(btn, opt_text)
		_safe_set_visible(btn, has_option)

	_safe_set_visible(active_answer_container, false)
	_safe_set_visible(active_answer_buttons_parent, false)


func _open_answer_buttons_for(player_index: int) -> void:
	_set_question_phase(QuestionPhase.ANSWERING)
	_show_question_text(false)
	_safe_set_visible(active_answer_container, true)
	_safe_set_visible(active_answer_buttons_parent, true)
	_safe_set_visible(active_selected_choice_container, false)
	_safe_set_visible(active_result_container, false)
	for btn in active_answer_button_nodes:
		btn.disabled = false
	if (
		nav_focus_enabled
		and not active_answer_button_nodes.is_empty()
		and active_answer_button_nodes[0]
	):
		active_answer_button_nodes[0].grab_focus()
	_start_answer_timer(answering_timer_seconds)


func _on_player_buzz(player_index: int) -> void:
	if current_clue.is_empty():
		return
	if question_phase != QuestionPhase.READING:
		return
	if buzzed_player != -1:
		return
	if attempted_players.has(player_index):
		return

	buzzed_player = player_index
	answering_player = player_index
	_lock_answering_input(player_index)
	_set_active_team(player_index)
	var is_ai: bool = players[player_index].get("is_ai", false)

	if _is_final_phase():
		return

	if is_ai:
		_open_answer_buttons_for(player_index)
		# Fresh 30s for AI answer
		_start_answer_timer(answering_timer_seconds)
		_queue_ai_answer()
		return

	# Human player:
	_open_answer_buttons_for(player_index)

	# Fresh 30s for human answer
	_start_answer_timer(answering_timer_seconds)


func _on_answer_selected(answer_text: String) -> void:
	_play_select_sfx()
	if buzzed_player == -1:
		return
	if not _is_final_phase() and question_phase != QuestionPhase.ANSWERING:
		return
	if _is_final_question_state() and final_question_revealed:
		_record_final_answer(answer_text)
		return
	if _is_final_wager_state() and not final_wager_set:
		_show_result(_t("Set your wager first.", "Defina sua aposta antes."), Color(0.9, 0.3, 0.3))
		return
	_set_question_phase(QuestionPhase.SHOWING_SELECTED)
	var correct_answer: String = str(current_clue["answer"]).strip_edges().to_lower()
	var given: String = str(answer_text).strip_edges().to_lower()
	var value: int = int(current_clue.get("value", 0))
	var player_name := "Player"
	if buzzed_player >= 0 and buzzed_player < players.size():
		player_name = players[buzzed_player].get("name", "Player")
	if _is_final_phase() and current_wager > 0:
		value = current_wager
	var is_correct := given == correct_answer
	var all_attempted_after := false
	if not is_correct:
		attempted_players.append(buzzed_player)
	if is_correct:
		team_scores[buzzed_player] += value
		_sync_session_state_score(buzzed_player)
		_update_game_board_score(buzzed_player)
		_set_active_team(buzzed_player)
		_play_correct_sfx()
		_show_result(_t("Correct! %s +%d", "Correto! %s +%d") % [player_name, value])
	else:
		team_scores[buzzed_player] -= value
		_sync_session_state_score(buzzed_player)
		_update_game_board_score(buzzed_player)
		_play_wrong_sfx()
		_show_result(_t("Wrong. %s -%d", "Errado. %s -%d") % [player_name, value])
		all_attempted_after = attempted_players.size() >= players.size()
	_refresh_all_score_views()
	_stop_timers(true)
	_disable_answer_buttons()
	_safe_set_visible(active_answer_container, false)
	_show_selected_choice(answer_text)
	_show_question_text(false)
	_safe_set_visible(active_result_container, false)

	if _is_final_phase():
		_mark_clue_answered()
		return

	await get_tree().create_timer(selected_choice_display_seconds).timeout

	if is_correct:
		_end_question_audio()
		_mark_clue_answered()
		_safe_set_visible(question_panel, false)
		_clear_selected_choice()
		_safe_set_visible(result_container, false)
		_set_question_phase(QuestionPhase.IDLE)
		_set_game_board_interactive(true)
		return

	if all_attempted_after:
		var correct_text := _t("Answer: %s", "Resposta: %s") % str(current_clue.get("answer", ""))
		_clear_selected_choice()
		_show_result(correct_text)
		_safe_set_visible(active_result_container, true)
		await get_tree().create_timer(result_display_seconds).timeout
		_end_question_audio()
		_set_active_team(question_selector_team)
		_mark_clue_answered()
		_safe_set_visible(question_panel, false)
		_safe_set_visible(result_container, false)
		_set_question_phase(QuestionPhase.IDLE)
		_set_game_board_interactive(true)
		return

	_clear_selected_choice()
	_show_question_text(true)
	_update_player_portrait_highlight(-1)
	buzzed_player = -1
	answering_player = -1
	answering_input_lock.clear()
	_disable_answer_buttons()
	_safe_set_visible(active_answer_container, false)
	_show_result("", Color(0.1, 0.1, 0.1))
	_set_question_phase(QuestionPhase.READING)
	_start_answer_timer(reading_timer_seconds)
	_start_ai_buzz_timer(ai_buzz_delay_seconds)
	_set_game_board_interactive(false)


func _disable_answer_buttons() -> void:
	for btn in answer_button_nodes:
		if btn:
			btn.disabled = true
	for btn in wager_answer_button_nodes:
		if btn:
			btn.disabled = true
	_safe_set_visible(active_answer_container, false)
	_safe_set_visible(active_answer_buttons_parent, false)
	_safe_set_visible(answer_buttons, false)
	_safe_set_visible(wager_answer_buttons_parent, false)


func _handle_all_attempted() -> void:
	_show_result("", Color(0.1, 0.1, 0.1))
	_safe_set_visible(active_result_container, false)
	_end_question_audio()
	_disable_answer_buttons()
	_set_active_team(question_selector_team)
	_mark_clue_answered()
	answering_input_lock.clear()

	# If we've moved into the final round, the wager UI is now active.
	if _is_final_phase():
		return

	if question_panel:
		_safe_set_visible(question_panel, false)
	_set_game_board_interactive(true)
	_set_active_team(question_selector_team)


func _is_answer_timer_active() -> bool:
	return answer_countdown_timer != null


func _start_answer_timer(duration_seconds: float = answering_timer_seconds) -> void:
	_cancel_answer_timer()
	answer_time_left = int(round(duration_seconds))
	_update_timer_label(answer_time_left)
	_start_answer_timer_tick()


func _start_answer_timer_tick() -> void:
	_cancel_answer_timer(false)
	if answer_time_left <= 0:
		_update_timer_label(0)
		_on_answer_timer_timeout()
		return
	answer_countdown_timer = get_tree().create_timer(1.0)
	answer_countdown_timer.timeout.connect(_on_answer_timer_tick)


func _on_answer_timer_tick() -> void:
	answer_countdown_timer = null
	answer_time_left -= 1
	if answer_time_left < 0:
		answer_time_left = 0
	_update_timer_label(answer_time_left)
	if answer_time_left <= 0:
		_on_answer_timer_timeout()
		return
	_start_answer_timer_tick()


func _cancel_answer_timer(reset_time: bool = true) -> void:
	if answer_countdown_timer:
		if answer_countdown_timer.timeout.is_connected(_on_answer_timer_tick):
			answer_countdown_timer.timeout.disconnect(_on_answer_timer_tick)
		answer_countdown_timer = null
	if reset_time:
		answer_time_left = 0


func _update_timer_label(value: int) -> void:
	var target_label: Label = active_timer_label if active_timer_label else answer_timer_label
	if target_label:
		target_label.text = "%02d" % max(0, value)
		_safe_set_visible(target_label, true)


func _pause_answer_timer() -> void:
	_cancel_answer_timer(false)


func _resume_answer_timer_if_needed() -> void:
	if answer_time_left <= 0:
		return
	if question_phase != QuestionPhase.READING and question_phase != QuestionPhase.ANSWERING:
		return
	_update_timer_label(answer_time_left)
	_start_answer_timer_tick()


func _on_answer_timer_timeout() -> void:
	if _is_final_phase():
		if not final_question_revealed:
			_maybe_finish_wagers()
			return
		if final_question_revealed and buzzed_player != -1:
			_record_final_answer("")
			return

	if question_phase == QuestionPhase.READING:
		_show_result(_t("Time's up!", "Tempo esgotado!"), Color(0.8, 0.4, 0.0))
		_end_question_audio()
		_mark_clue_answered()
		_set_question_phase(QuestionPhase.IDLE)
		if _is_final_phase():
			return
		if question_panel:
			_safe_set_visible(question_panel, false)
		_disable_answer_buttons()
		_set_game_board_interactive(true)
		return

	if question_phase == QuestionPhase.ANSWERING:
		if buzzed_player == -1:
			return
		_on_answer_selected("")
		return


func _mark_clue_answered() -> void:
	var cat_index: int = current_clue.get("cat_index", -1)
	var clue_index: int = current_clue.get("clue_index", -1)
	var button: Button = current_clue.get("button", null)
	var tile_index: int = current_clue.get("tile_index", -1)

	if cat_index == -1 or clue_index == -1:
		current_clue.clear()
		_set_question_phase(QuestionPhase.IDLE)
		return

	var key := "%d-%d" % [cat_index, clue_index]
	answered_map[key] = true

	if button:
		button.disabled = true
		button.text = ""
	if tile_index != -1 and game_board:
		game_board.mark_tile_answered(tile_index)

	buzzed_player = -1
	attempted_players.clear()
	current_options.clear()
	_stop_timers(true)
	_reset_question_panel_color()
	answering_input_lock.clear()
	answering_player = -1
	_set_question_phase(QuestionPhase.IDLE)
	current_clue.clear()
	if _is_final_phase():
		final_wager_set = false
		_show_winner_trophies()
	else:
		_advance_round_if_needed()
		_maybe_trigger_ai_board_choice()
		_set_game_board_interactive(true)


func _restart_to_main_menu() -> void:
	_end_question_audio()
	_stop_timers()
	_cancel_final_results_timer()
	GameSessionState.reset()
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
	_safe_set_visible(controller_connect_panel, false)
	hidden_double_key = ""
	current_wager = 0
	final_question.clear()
	final_question_revealed = false
	final_wager_values.clear()
	final_wager_done.clear()
	final_answer_choices.clear()
	final_answered.clear()
	final_answer_index = 0
	_set_question_phase(QuestionPhase.IDLE)
	players.clear()
	team_names.clear()
	team_scores.clear()
	team_score_labels.clear()
	team_cards.clear()
	team_trophies.clear()
	team_wager_labels.clear()
	pending_allow_keyboard_fallback = true
	player_characters.clear()
	_stop_team_card_pulse()
	_show_result("")
	q_text_label.text = ""
	if wager_q_text_label:
		wager_q_text_label.text = ""
	if active_question_text_label:
		active_question_text_label.text = ""
	if q_category_label:
		q_category_label.text = ""
	if q_value_label:
		q_value_label.text = ""
	_clear_selected_choice()
	if question_panel:
		_safe_set_visible(question_panel, false)
	_safe_set_visible(wager_panel, false)
	_show_game_board(false)
	_safe_set_visible(final_results_panel, false)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_spacer_panel, false)
	_close_pause_menu()
	_reset_round_state()
	_show_title()
	_play_background_music()


func _on_exit_pressed() -> void:
	_save_settings(true)
	get_tree().quit()


func _on_play_again_pressed() -> void:
	_play_select_sfx()
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.MAIN_MENU)
		await get_tree().process_frame
		game_state_machine.transition_to(GameStateMachine.State.CONTROLLER_SETUP)
	else:
		_restart_to_main_menu()
		await get_tree().process_frame
		_on_play_pressed()


func _stop_timers(preserve_result: bool = false) -> void:
	_cancel_answer_timer()
	_cancel_ai_buzz_timer()
	_cancel_wager_timer()

	if not preserve_result:
		if active_result_label:
			active_result_label.text = ""
		elif result_label:
			result_label.text = ""


func _show_result(text: String, _color: Color = Color(0.1, 0.1, 0.1)) -> void:
	if active_result_label:
		active_result_label.text = text
	elif result_label:
		result_label.text = text


func _maybe_focus_for_nav() -> void:
	if not nav_focus_enabled:
		return
	var current_focus := get_viewport().gui_get_focus_owner()
	if current_focus and current_focus.visible:
		return
	if controller_connect_panel and controller_connect_panel.visible and controller_continue_button:
		controller_continue_button.grab_focus()
		return
	if settings_panel and settings_panel.visible and language_option:
		language_option.grab_focus()
		return
	if game_board and is_instance_valid(game_board) and game_board.visible:
		if game_board.has_method("focus_first_available_tile"):
			game_board.call("focus_first_available_tile")
		elif game_board is Control:
			(game_board as Control).grab_focus()
		return
	if title_panel and title_panel.visible and title_play_button:
		title_play_button.grab_focus()
		return


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
	if not _is_round_play_state():
		return
	if not current_clue.is_empty():
		return
	if current_turn_team < 0 or current_turn_team >= players.size():
		return
	var p := players[current_turn_team]
	if not p.get("is_ai", false):
		return
	await get_tree().create_timer(ai_board_pick_delay_seconds).timeout
	if not _is_round_play_state() or not current_clue.is_empty():
		return
	if game_board == null:
		return
	var available := game_board.get_unanswered_tile_indices()
	if available.is_empty():
		return
	var pick_idx := available[rng.randi_range(0, available.size() - 1)]
	var tile_state := game_board.get_tile_state(pick_idx)
	_on_game_board_tile_pressed(tile_state, pick_idx)


func _reset_round_state(
	new_round_index: int = 0, refresh_category_deck: bool = true, preserve_turn_team: bool = false
) -> void:
	round_index = new_round_index
	current_wager = 0
	final_wager_player = -1
	final_wager_set = false
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
	if refresh_category_deck:
		category_deck = LoadedBibleData.get_categories()
	answered_map.clear()
	if not preserve_turn_team:
		current_turn_team = 0
		question_selector_team = 0
	answering_player = -1
	team_trophies.clear()
	team_wager_labels.clear()
	_clear_wager_labels()
	_safe_set_visible(wager_panel, false)
	_use_regular_question_ui()
	_clear_selected_choice()
	_reset_question_panel_color()


func _select_hidden_double(num_categories: int, num_clues: int) -> void:
	if num_categories <= 0:
		hidden_double_key = ""
		return
	var cat_index: int = rng.randi_range(0, num_categories - 1)
	var clue_index: int = rng.randi_range(0, max(0, num_clues - 1))
	hidden_double_key = "%d-%d" % [cat_index, clue_index]


func _advance_round_if_needed() -> void:
	if _is_final_phase() or _is_results_state():
		return
	if total_clues_this_round == 0:
		return
	if answered_map.size() >= total_clues_this_round:
		hidden_double_key = ""
		answered_map.clear()
		if game_state_machine:
			if game_state_machine.is_in_state(GameStateMachine.State.ROUND_1):
				game_state_machine.transition_to(GameStateMachine.State.ROUND_1_TO_2_TRANSITION)
			elif game_state_machine.is_in_state(GameStateMachine.State.ROUND_2):
				game_state_machine.transition_to(GameStateMachine.State.FINAL_JEOPARDY_WAGER)
		else:
			round_index += 1
			if round_index >= ROUND_VALUES.size():
				_start_final_round()
			else:
				_show_result(
					_t("Round %d!", "Rodada %d!") % (round_index + 1), Color(0.6, 0.8, 1.0)
				)


func _start_final_round() -> void:
	round_index = ROUND_VALUES.size()
	current_wager = 0
	current_options.clear()
	total_clues_this_round = 0
	answered_map.clear()
	attempted_players.clear()
	final_wager_player = -1
	final_wager_set = false
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

	current_clue.clear()
	current_categories = []

	if q_category_label:
		q_category_label.text = ""
	if q_value_label:
		q_value_label.text = ""
	q_text_label.text = ""
	_show_result("")
	_clear_selected_choice()

	_disable_answer_buttons()
	_hide_question_ui_for_wager()
	_safe_set_visible(game_board, false)
	_show_wager_panel_ui()


func _calculate_auto_wager(idx: int) -> int:
	if idx < 0 or idx >= team_scores.size():
		return 0
	return int(round(abs(team_scores[idx]) * 0.1))


func _show_wager_panel_ui() -> void:
	_cancel_wager_timer()
	_connect_wager_buttons() # ensure wager buttons stay wired even after scene reloads
	_hide_question_ui_for_wager()
	_safe_set_visible(wager_panel, true)
	_safe_set_visible(wager_question_panel, false)
	_safe_set_visible(wager_spacer_panel, true)
	_safe_set_visible(wager_container, true)
	_safe_set_visible(wager_hbox_player_container, true)
	_safe_set_visible(final_results_panel, false)
	_sync_wager_top_cards()
	_refresh_all_score_views()
	if active_timer_label:
		_safe_set_visible(active_timer_label, false)
	if wager_timer_container:
		_safe_set_visible(wager_timer_container, false)
	if wager_timer_label:
		_safe_set_visible(wager_timer_label, false)

	var cat_name := (
		str(final_question.get("category", _t("Final Jeopardy", "Rodada final")))
		if final_question
		else _t("Final Jeopardy", "Rodada final")
	)
	if wager_category_label:
		wager_category_label.text = cat_name
		_safe_set_visible(wager_category_label, true)
	if wager_category_panel:
		_safe_set_visible(wager_category_panel, true)

	# Ensure arrays sized
	_ensure_wager_arrays()
	for i in range(players.size()):
		if i < final_wager_values.size():
			final_wager_values[i] = 0
		if i < final_wager_done.size():
			final_wager_done[i] = false

	for i in range(wager_player_name_labels.size()):
		var has_player := i < players.size()
		var card_data := _player_card_data(i) if has_player else {}
		var name_lbl := wager_player_name_labels[i]
		var amt_lbl := wager_amount_labels[i] if i < wager_amount_labels.size() else null
		var buttons: Array = wager_choice_buttons[i] if i < wager_choice_buttons.size() else []
		if name_lbl:
			name_lbl.visible = has_player
			if has_player:
				name_lbl.text = str(card_data.get("name", _display_player_name_for_ui(i)))
		if amt_lbl:
			amt_lbl.visible = has_player
			if has_player:
				var score_raw: int = int(card_data.get("score", 0))
				var score_max: int = abs(score_raw)
				amt_lbl.text = _t("Wager: $0 (of $%d)", "Aposta: $0 (de $%d)") % score_max
		var auto_wager: int = -1
		if has_player:
			var is_ai: bool = bool(card_data.get("is_ai", false))
			var score: int = int(card_data.get("score", 0))
			if score < 0:
				auto_wager = int(round(abs(score) * 0.1))
			elif is_ai:
				auto_wager = int(round(abs(score) * 0.5))

		if has_player and auto_wager >= 0:
			if i < final_wager_values.size():
				final_wager_values[i] = auto_wager
			if i < final_wager_done.size():
				final_wager_done[i] = true
			if amt_lbl:
				amt_lbl.text = _t("Wager: $%d", "Aposta: $%d") % auto_wager
			for b in buttons:
				if b:
					b.visible = false
					b.disabled = true
		else:
			for b in buttons:
				if b:
					b.visible = has_player
					b.disabled = not has_player

	_check_all_wagers_selected()
	if not final_wager_set:
		_start_wager_timer(FINAL_WAGER_TIME)


func _check_all_wagers_selected() -> void:
	for i in range(players.size()):
		if i >= final_wager_done.size() or not final_wager_done[i]:
			return
	_cancel_wager_timer()
	final_wager_set = true
	final_wager_timer = get_tree().create_timer(final_wager_summary_delay_seconds)
	final_wager_timer.timeout.connect(
		func() -> void:
			if game_state_machine:
				game_state_machine.transition_to(GameStateMachine.State.FINAL_JEOPARDY_QUESTION)
			else:
				_reveal_final_question()
	)
	_update_wager_timer_label(0)


func _ensure_wager_arrays() -> void:
	if players.is_empty():
		return
	if final_wager_values.size() < players.size():
		final_wager_values.resize(players.size())
	if final_wager_done.size() < players.size():
		final_wager_done.resize(players.size())
	if final_answer_choices.size() < players.size():
		final_answer_choices.resize(players.size())
	if final_answered.size() < players.size():
		final_answered.resize(players.size())


func _on_wager_choice(idx: int, pct: float) -> void:
	if idx < 0 or idx >= players.size():
		return
	# Ensure wager arrays are large enough (defensive for any edge-case clears).
	_ensure_wager_arrays()
	var score: int = abs(team_scores[idx]) if team_scores.size() > idx else 0
	var wager: int = int(round(score * pct))

	print_debug("WAGER CHOICE -> idx=%d pct=%.2f score=%d wager=%d" % [idx, pct, score, wager])

	final_wager_values[idx] = wager
	final_wager_done[idx] = true
	if idx < wager_amount_labels.size():
		var lbl := wager_amount_labels[idx]
		if lbl:
			lbl.text = _t("Wager: $%d", "Aposta: $%d") % wager
	result_label.text = _t("Wager set: %d", "Aposta definida: %d") % wager
	_show_result(result_label.text, Color(0.15, 0.45, 0.15))
	_check_all_wagers_selected()


func _maybe_finish_wagers() -> void:
	_check_all_wagers_selected()


func _on_all_wagers_done() -> void:
	final_wager_player = -1
	final_wager_set = true
	print_debug("Explicit all wagers done call; revealing final question.")
	if game_state_machine:
		if game_state_machine.is_in_state(GameStateMachine.State.FINAL_JEOPARDY_QUESTION):
			_enter_final_question_state()
		else:
			game_state_machine.transition_to(GameStateMachine.State.FINAL_JEOPARDY_QUESTION)
	else:
		_reveal_final_question()


func _reveal_final_question() -> void:
	_use_wager_question_ui()
	final_question_revealed = true
	print_debug("Reveal final question.")
	_cancel_ai_buzz_timer()
	_disable_answer_buttons()
	_clear_wager_labels()
	_safe_set_visible(question_panel, false)
	_safe_set_visible(question_header_container, false)
	_safe_set_visible(game_board, false)
	_safe_set_visible(wager_container, false)
	_safe_set_visible(wager_hbox_player_container, true)
	_safe_set_visible(wager_timer_container, true)
	_safe_set_visible(wager_timer_label, false)
	_safe_set_visible(wager_category_label, false)
	_safe_set_visible(wager_category_panel, false)
	_safe_set_visible(wager_spacer_panel, false)
	_safe_set_visible(wager_panel, true)
	_safe_set_visible(wager_question_panel, true)
	_safe_set_visible(final_results_panel, false)

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

	current_categories = [ {"name": category_name, "values": []}]

	if q_category_label:
		q_category_label.text = ""
	_safe_set_visible(q_category_label, false)
	if q_value_label:
		q_value_label.text = ""
	_safe_set_visible(q_value_label, false)
	if q_text_label:
		q_text_label.text = ""
	if active_question_text_label:
		active_question_text_label.text = ""
	_show_question_text(true)
	_clear_selected_choice()
	var reveal_message := _t(
		"Final question revealed. Answer in turn.", "Pergunta final revelada. Responda em sua vez."
	)
	_show_result(reveal_message)
	_safe_set_visible(active_result_container, false)
	_build_answer_options(current_clue)
	if active_question_text_label:
		active_question_text_label.text = question_text
	is_typing_question = false
	_set_question_phase(QuestionPhase.READING)
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
	_set_question_phase(QuestionPhase.ANSWERING)
	buzzed_player = idx
	answering_player = idx
	_lock_answering_input(idx)
	_set_active_team(idx)
	_show_result("")
	_safe_set_visible(active_result_container, false)
	for btn in active_answer_button_nodes:
		if btn:
			btn.disabled = false
	_safe_set_visible(active_answer_container, true)
	_safe_set_visible(active_answer_buttons_parent, true)
	if nav_focus_enabled and not active_answer_button_nodes.is_empty() and active_answer_button_nodes[0]:
		active_answer_button_nodes[0].grab_focus()
	_start_answer_timer(answering_timer_seconds)
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
	_disable_answer_buttons()
	_stop_team_card_pulse()
	var correct_answer_raw := str(current_clue.get("answer", ""))
	var correct_answer := correct_answer_raw.strip_edges().to_lower()
	for i in range(players.size()):
		var wager: int = final_wager_values[i] if i < final_wager_values.size() else 0
		var choice := ""
		if i < final_answer_choices.size():
			choice = final_answer_choices[i]
		var is_correct := str(choice).strip_edges().to_lower() == correct_answer
		if is_correct:
			team_scores[i] += wager
		else:
			team_scores[i] -= wager
		_sync_session_state_score(i)
		_update_game_board_score(i)

	_safe_set_visible(active_answer_container, false)
	_safe_set_visible(active_answer_buttons_parent, false)
	_safe_set_visible(active_selected_choice_container, false)
	_stop_timers(true)
	_safe_set_visible(active_timer_label, false)
	_safe_set_visible(wager_timer_container, false)
	_safe_set_visible(game_board, false)
	_safe_set_visible(wager_panel, true)
	_safe_set_visible(wager_container, false)
	_safe_set_visible(wager_hbox_player_container, true)
	_safe_set_visible(wager_spacer_panel, true)
	_safe_set_visible(wager_question_panel, true)
	_safe_set_visible(question_panel, false)
	_safe_set_visible(question_header_container, false)
	_safe_set_visible(active_result_container, true)
	_set_question_phase(QuestionPhase.SHOWING_RESULT)

	var reveal_text := _t("Answer: %s", "Resposta: %s") % correct_answer_raw
	_show_result(reveal_text, Color(0.1, 0.1, 0.1))

	if final_answer_reveal_seconds > 0.0:
		await get_tree().create_timer(final_answer_reveal_seconds).timeout

	# After revealing the correct answer, move to the final results view
	_refresh_all_score_views()
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.RESULTS)
		return
	_enter_results_state()


func _unhandled_input(event: InputEvent) -> void:
	# Quick input-blocker debug (temporary): shows what Control is under the mouse
	# and what currently owns focus when pressing ui_accept.
	if event is InputEventMouseButton and event.pressed:
		var hovered: Control = get_viewport().gui_get_hovered_control()
		var hovered_path := "null"
		if hovered and is_instance_valid(hovered):
			hovered_path = str(hovered.get_path())
		print("CLICK hovered=", hovered, " path=", hovered_path)

	if event.is_action_pressed("ui_accept"):
		var focus_owner: Control = get_viewport().gui_get_focus_owner()
		var focus_path := "null"
		if focus_owner and is_instance_valid(focus_owner):
			focus_path = str(focus_owner.get_path())
		print("ACCEPT focus_owner=", focus_owner, " path=", focus_path)

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


func _start_ai_buzz_timer(delay: float = ai_buzz_delay_seconds) -> void:
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


func _start_wager_timer(duration: float = FINAL_WAGER_TIME) -> void:
	_cancel_wager_timer()
	final_wager_time_left = int(round(duration))
	_update_wager_timer_label(final_wager_time_left)
	final_wager_timer = get_tree().create_timer(duration)
	final_wager_timer.timeout.connect(_on_final_wager_timeout)
	final_wager_countdown_timer = get_tree().create_timer(1.0)
	final_wager_countdown_timer.timeout.connect(_on_wager_timer_tick)


func _cancel_wager_timer() -> void:
	if final_wager_timer:
		if is_instance_valid(final_wager_timer):
			if final_wager_timer.timeout.is_connected(_on_final_wager_timeout):
				final_wager_timer.timeout.disconnect(_on_final_wager_timeout)
	final_wager_timer = null
	if final_wager_countdown_timer:
		if is_instance_valid(final_wager_countdown_timer):
			if final_wager_countdown_timer.timeout.is_connected(_on_wager_timer_tick):
				final_wager_countdown_timer.timeout.disconnect(_on_wager_timer_tick)
	final_wager_countdown_timer = null
	final_wager_time_left = 0
	_update_wager_timer_label(final_wager_time_left)


func _cancel_final_results_timer() -> void:
	if final_results_timer:
		if is_instance_valid(final_results_timer):
			if final_results_timer.timeout.is_connected(_on_final_results_timeout):
				final_results_timer.timeout.disconnect(_on_final_results_timeout)
	final_results_timer = null


func _on_final_results_timeout() -> void:
	final_results_timer = null
	if game_state_machine:
		game_state_machine.transition_to(GameStateMachine.State.MAIN_MENU, {}, true)
	else:
		_restart_to_main_menu()


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
		if i < wager_amount_labels.size():
			var lbl := wager_amount_labels[i]
			if lbl:
				lbl.text = _t("Wager: $%d", "Aposta: $%d") % auto_wager
		print_debug("Final wager timeout -> auto wager player=%d wager=%d" % [i, auto_wager])
	_maybe_finish_wagers()


func _on_wager_timer_tick() -> void:
	final_wager_countdown_timer = null
	final_wager_time_left -= 1
	if final_wager_time_left < 0:
		final_wager_time_left = 0
	_update_wager_timer_label(final_wager_time_left)
	if final_wager_time_left <= 0:
		return
	final_wager_countdown_timer = get_tree().create_timer(1.0)
	final_wager_countdown_timer.timeout.connect(_on_wager_timer_tick)


func _update_wager_timer_label(value: int) -> void:
	if wager_timer_label:
		wager_timer_label.text = "%02d" % max(0, value)
		# Keep hidden during wager screen per request


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
				_safe_set_visible(settings_panel, false)
				_open_pause_menu()
		elif pause_menu.visible:
			_play_select_sfx()
			if game_state_machine:
				game_state_machine.resume()
			else:
				_close_pause_menu()
				_resume_answer_timer_if_needed()
		elif _can_open_pause_menu():
			_play_select_sfx()
			if game_state_machine:
				game_state_machine.pause()
			else:
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
