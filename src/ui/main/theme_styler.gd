extends RefCounted
class_name ThemeStyler

var theme_body_color: Color
var team_colors: Array


func _init(theme_body_color: Color, team_colors: Array) -> void:
	self.theme_body_color = theme_body_color
	self.team_colors = team_colors


func apply_font_override(control: Control, game_font: Font) -> void:
	if control == null or not is_instance_valid(control):
		return
	if game_font and game_font.get_height() > 0:
		control.add_theme_font_override("font", game_font)
		if control.has_method("set_autowrap_mode"):
			control.set_autowrap_mode(TextServer.AUTOWRAP_WORD)
		if control.has_method("set_horizontal_alignment"):
			control.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)


func apply_body_color(control: Control) -> void:
	if control == null or not is_instance_valid(control):
		return
	control.add_theme_color_override("font_color", theme_body_color)


func apply_game_font(game_font: Font, controls: Array) -> void:
	for ctrl in controls:
		apply_font_override(ctrl, game_font)


func setup_background(parent: Control, existing: TextureRect) -> TextureRect:
	if existing and is_instance_valid(existing):
		return existing
	var background_rect := TextureRect.new()
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

	parent.add_child(background_rect)
	parent.move_child(background_rect, 0)
	return background_rect


func apply_bible_theme(
	title_screen_title: Label,
	title_label: Label,
	primary_controls: Array,
	settings_language_label: Label,
	music_label: Label,
	answer_timer_label: Label,
	question_panel: PanelContainer,
	pause_panel: Control,
	button_controls: Array,
	game_font: Font,
	timer_bar: Node,
	answer_time: float
) -> StyleBoxFlat:
	var title_color := Color(0.05, 0.08, 0.2)
	if title_screen_title:
		title_screen_title.add_theme_color_override("font_color", title_color)
		title_screen_title.add_theme_font_size_override("font_size", 48)
		title_screen_title.visible = false
	if title_label:
		title_label.add_theme_color_override("font_color", title_color)
		title_label.add_theme_font_size_override("font_size", 42)
		title_label.visible = false

	for ctrl in primary_controls:
		if ctrl and ctrl is Control:
			apply_body_color(ctrl)
			(ctrl as Control).add_theme_font_size_override("font_size", 28)
	if settings_language_label:
		settings_language_label.add_theme_font_size_override("font_size", 32)
	if music_label:
		music_label.add_theme_font_size_override("font_size", 32)
	if answer_timer_label:
		answer_timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	style_timer_bar(timer_bar, answer_time)

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
		question_panel.add_theme_stylebox_override("panel", parchment.duplicate())

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

	for btn in button_controls:
		if btn:
			btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			btn.custom_minimum_size = Vector2(320, 72)
			btn.add_theme_stylebox_override("normal", button_normal)
			btn.add_theme_stylebox_override("hover", button_hover)
			btn.add_theme_stylebox_override("pressed", button_pressed)
			btn.add_theme_stylebox_override("disabled", button_disabled)
			apply_font_override(btn, game_font)

	return parchment


func style_timer_bar(timer_bar: Node, answer_time: float) -> void:
	if timer_bar == null or not is_instance_valid(timer_bar):
		return
	if timer_bar.has_method("set_time_left"):
		timer_bar.call("set_time_left", answer_time)
	if timer_bar is TimerBar:
		var tb := timer_bar as TimerBar
		tb.duration_seconds = answer_time
	if timer_bar is Control:
		(timer_bar as Control).visible = true


func team_color(idx: int) -> Color:
	if idx < team_colors.size():
		return team_colors[idx]
	return team_colors[idx % team_colors.size()]


func apply_team_card_style(card: PanelContainer, color: Color, highlighted: bool) -> void:
	if card == null or not is_instance_valid(card):
		return
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.04, 0.16).lerp(color, 0.1)
	style.border_color = color.lightened(0.12)
	var border := 5 if highlighted else 2
	style.border_width_left = border
	style.border_width_right = border
	style.border_width_top = border
	style.border_width_bottom = border
	style.shadow_size = 16 if highlighted else 10
	var shadow_alpha := 0.26 if highlighted else 0.14
	style.shadow_color = Color(color.r, color.g, color.b, shadow_alpha)
	style.corner_radius_top_left = 14
	style.corner_radius_top_right = 14
	style.corner_radius_bottom_left = 14
	style.corner_radius_bottom_right = 14
	card.add_theme_stylebox_override("panel", style)


func refresh_team_highlight(team_cards: Array, current_turn_team: int) -> void:
	for i in range(team_cards.size()):
		var card: PanelContainer = team_cards[i] as PanelContainer
		var color := team_color(i)
		var is_active := i == current_turn_team
		apply_team_card_style(card, color, is_active)
		if card and card.has_node("HighlightOverlay"):
			var overlay := card.get_node("HighlightOverlay") as ColorRect
			overlay.visible = is_active
			if overlay.material and overlay.material is ShaderMaterial:
				(overlay.material as ShaderMaterial).set_shader_parameter("border_color", color)


func set_question_panel_color(
	question_panel: PanelContainer, base_style: StyleBox, color: Color
) -> void:
	if question_panel == null or not is_instance_valid(question_panel) or base_style == null:
		return
	var styled := base_style.duplicate()
	styled.shadow_color = Color(color.r, color.g, color.b, 0.28)
	styled.shadow_size = 20
	question_panel.add_theme_stylebox_override("panel", styled)


func reset_question_panel_color(question_panel: PanelContainer, base_style: StyleBox) -> void:
	if question_panel == null or not is_instance_valid(question_panel) or base_style == null:
		return
	question_panel.add_theme_stylebox_override("panel", base_style.duplicate())
