extends RefCounted
class_name SettingsScreen

var title_panel: Control
var settings_panel: Control
var pause_menu: Control
var question_panel: Control


func _init(
	title_panel: Control, settings_panel: Control, pause_menu: Control, question_panel: Control
) -> void:
	self.title_panel = title_panel
	self.settings_panel = settings_panel
	self.pause_menu = pause_menu
	self.question_panel = question_panel


func show_settings_from_title() -> void:
	if title_panel:
		title_panel.visible = false
	if question_panel:
		question_panel.visible = false
	if pause_menu:
		pause_menu.visible = false
	if settings_panel:
		settings_panel.visible = true


func show_settings_from_pause() -> void:
	if settings_panel:
		settings_panel.visible = true
	if pause_menu:
		pause_menu.visible = false


func back_to_title() -> void:
	if settings_panel:
		settings_panel.visible = false
	if title_panel:
		title_panel.visible = true
	if pause_menu:
		pause_menu.visible = false


func back_to_pause() -> void:
	if settings_panel:
		settings_panel.visible = false
	if pause_menu:
		pause_menu.visible = true
