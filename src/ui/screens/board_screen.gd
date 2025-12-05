extends RefCounted
class_name BoardScreen

const ThemeStyler = preload("res://src/ui/main/theme_styler.gd")

var theme_styler: ThemeStyler
var game_font: Font


func _init(theme_styler: ThemeStyler, game_font: Font) -> void:
	self.theme_styler = theme_styler
	self.game_font = game_font


func update_player_info_label(player_info_label: Label, t_func: Callable) -> void:
	if player_info_label == null:
		return
	var info: String = str(
		t_func.call(
			"Three players always. Keyboard is Player 1 (Spacebar buzz).\n",
			"Sempre tres jogadores. Teclado e o Jogador 1 (barra de espaco).\n"
		)
	)
	info += str(
		t_func.call(
			"Press Play to join, pick characters, then start; empty slots become AI.",
			"Aperte Jogar para entrar, escolha personagens e inicie; vagas vazias viram IA."
		)
	)
	player_info_label.text = info


func build_teams(
	team_names: Array[String],
	team_scores: Array,
	team_score_labels: Array,
	team_cards: Array,
	team_trophies: Array,
	team_wager_labels: Array,
	team_portraits: Array,
	scoreboard: HBoxContainer,
	t_func: Callable,
	player_data: Array = []
) -> void:
	if scoreboard == null or not is_instance_valid(scoreboard):
		push_warning("Scoreboard node missing; cannot build teams.")
		return

	scoreboard.add_theme_constant_override("separation", 32)

	_clear_children(scoreboard)
	team_scores.clear()
	team_score_labels.clear()
	team_cards.clear()
	team_trophies.clear()
	team_wager_labels.clear()

	for i in range(team_names.size()):
		var team_name: String = team_names[i].strip_edges()
		if team_name == "":
			continue

		var color := theme_styler.team_color(i) if theme_styler else Color.WHITE
		team_scores.append(0)

		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(260, 170)
		if theme_styler:
			theme_styler.apply_team_card_style(card, color, false)

		var highlight := _make_highlight_overlay(color)
		card.add_child(highlight)

		var content := VBoxContainer.new()
		content.alignment = BoxContainer.ALIGNMENT_CENTER
		content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		content.size_flags_vertical = Control.SIZE_EXPAND_FILL
		content.add_theme_constant_override("separation", 6)
		card.add_child(content)

		var vbox := content

		var name_label := Label.new()
		name_label.text = team_name.to_upper()
		if theme_styler:
			theme_styler.apply_font_override(name_label, game_font)
			theme_styler.apply_body_color(name_label)
		name_label.add_theme_font_size_override("font_size", 22)
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		var name_bar := _make_name_bar(name_label, color)

		var portrait := _make_portrait_panel(
			team_portraits[i] if team_portraits.size() > i else {}, theme_styler.team_color(i)
		)

		var trophy := Label.new()
		trophy.text = "Winner"
		trophy.visible = false
		trophy.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		if theme_styler:
			theme_styler.apply_font_override(trophy, game_font)
			theme_styler.apply_body_color(trophy)
		trophy.add_theme_font_size_override("font_size", 32)

		var wager_label := Label.new()
		wager_label.text = ""
		wager_label.visible = false
		wager_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		if theme_styler:
			theme_styler.apply_font_override(wager_label, game_font)
			theme_styler.apply_body_color(wager_label)
		wager_label.add_theme_font_size_override("font_size", 18)

		var status_label := Label.new()
		status_label.text = _status_text(player_data, i)
		if theme_styler:
			theme_styler.apply_font_override(status_label, game_font)
			theme_styler.apply_body_color(status_label)
		status_label.add_theme_font_size_override("font_size", 14)
		status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		var score_label := Label.new()
		score_label.text = _format_score(0, t_func)
		if theme_styler:
			theme_styler.apply_font_override(score_label, game_font)
			theme_styler.apply_body_color(score_label)
		score_label.add_theme_font_size_override("font_size", 28)
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		var portrait_column := VBoxContainer.new()
		portrait_column.alignment = BoxContainer.ALIGNMENT_CENTER
		portrait_column.add_child(portrait)
		portrait_column.add_child(status_label)

		var row := HBoxContainer.new()
		row.alignment = BoxContainer.ALIGNMENT_CENTER
		row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_theme_constant_override("separation", 12)
		row.add_child(score_label)
		row.add_child(portrait_column)

		vbox.add_child(trophy)
		vbox.add_child(name_bar)
		vbox.add_child(row)
		vbox.add_child(wager_label)

		team_score_labels.append(score_label)
		team_cards.append(card)
		team_trophies.append(trophy)
		team_wager_labels.append(wager_label)

		scoreboard.add_child(card)


func set_score_label(
	idx: int, team_scores: Array, team_score_labels: Array, t_func: Callable
) -> void:
	if idx < 0 or idx >= team_score_labels.size():
		return
	team_score_labels[idx].text = _format_score(team_scores[idx], t_func)


func _make_portrait_panel(portrait_data: Dictionary, fallback_color: Color) -> PanelContainer:
	var bg: Color = portrait_data.get("bg", fallback_color)
	var accent: Color = portrait_data.get("accent", fallback_color.darkened(0.2))
	var letter: String = ""
	if portrait_data.has("name"):
		var n := str(portrait_data.get("name", ""))
		if n.length() > 0:
			letter = n.substr(0, 1).to_upper()

	var portrait := PanelContainer.new()
	portrait.custom_minimum_size = Vector2(96, 96)
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = accent
	style.set_border_width_all(3)
	style.set_corner_radius_all(14)
	style.shadow_size = 12
	style.shadow_color = Color(0, 0, 0, 0.25)
	portrait.add_theme_stylebox_override("panel", style)

	var center := CenterContainer.new()
	center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	portrait.add_child(center)

	var label := Label.new()
	label.text = letter
	if theme_styler:
		theme_styler.apply_font_override(label, game_font)
		theme_styler.apply_body_color(label)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 44)
	center.add_child(label)

	return portrait


func _make_name_bar(name_label: Label, color: Color) -> PanelContainer:
	var bar := PanelContainer.new()
	bar.custom_minimum_size = Vector2(0, 38)
	var style := StyleBoxFlat.new()
	style.bg_color = color.lightened(0.35)
	style.set_corner_radius_all(12)
	style.shadow_size = 6
	style.shadow_color = Color(0, 0, 0, 0.18)
	bar.add_theme_stylebox_override("panel", style)
	bar.add_child(name_label)
	return bar


func _make_highlight_overlay(color: Color) -> ColorRect:
	var shader := Shader.new()
	shader.code = """
shader_type canvas_item;
uniform vec4 border_color : hint_color;
uniform float border = 0.06;
uniform float softness = 0.03;
uniform float speed = 1.8;

void fragment() {
	vec2 dist = min(UV, 1.0 - UV);
	float edge = min(dist.x, dist.y);
	float ring = 1.0 - smoothstep(border, border + softness, edge);
	float ang = atan(UV.y - 0.5, UV.x - 0.5);
	float sweep = 0.55 + 0.45 * sin(ang * 6.0 + TIME * speed);
	float alpha = ring * sweep;
	COLOR = vec4(border_color.rgb, border_color.a * alpha);
}
"""
	var mat := ShaderMaterial.new()
	mat.shader = shader
	mat.set_shader_parameter("border_color", color)

	var rect := ColorRect.new()
	rect.name = "HighlightOverlay"
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	rect.offset_left = 0
	rect.offset_top = 0
	rect.offset_right = 0
	rect.offset_bottom = 0
	rect.color = Color(1, 1, 1, 0)
	rect.material = mat
	rect.visible = false
	rect.z_index = 4
	return rect


func _status_text(player_data: Array, idx: int) -> String:
	if idx < player_data.size():
		var pdata := player_data[idx] as Dictionary
		if pdata.get("is_ai", false):
			return "A.I."
	return "Player"


func _format_score(score: int, t_func: Callable) -> String:
	var abs_value: int = abs(score)
	var formatted: String = "%d" % abs_value
	var prefix: String = "$" if score >= 0 else "-$"
	return t_func.call("%s%s", "%s%s") % [prefix, formatted]


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()
