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
	t_func: Callable
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

		team_scores.append(0)

		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(220, 150)
		if theme_styler:
			theme_styler.apply_team_card_style(card, theme_styler.team_color(i), false)

		var vbox := VBoxContainer.new()
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

		var name_label := Label.new()
		name_label.text = team_name
		if theme_styler:
			theme_styler.apply_font_override(name_label, game_font)
			theme_styler.apply_body_color(name_label)
		name_label.add_theme_font_size_override("font_size", 24)
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		var portrait := _make_portrait_panel(
			team_portraits[i] if team_portraits.size() > i else {}, theme_styler.team_color(i)
		)

		var trophy := Label.new()
		trophy.text = "Trophy"
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

		var score_label := Label.new()
		score_label.text = t_func.call("Points: 0", "Pontos: 0")
		if theme_styler:
			theme_styler.apply_font_override(score_label, game_font)
			theme_styler.apply_body_color(score_label)
		score_label.add_theme_font_size_override("font_size", 22)
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		vbox.add_child(trophy)
		vbox.add_child(wager_label)
		vbox.add_child(portrait)
		vbox.add_child(name_label)
		vbox.add_child(score_label)

		card.add_child(vbox)
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
	team_score_labels[idx].text = t_func.call("Points: %s", "Pontos: %s") % team_scores[idx]


func _make_portrait_panel(portrait_data: Dictionary, fallback_color: Color) -> PanelContainer:
	var bg: Color = portrait_data.get("bg", fallback_color)
	var accent: Color = portrait_data.get("accent", fallback_color.darkened(0.2))
	var letter: String = ""
	if portrait_data.has("name"):
		var n := str(portrait_data.get("name", ""))
		if n.length() > 0:
			letter = n.substr(0, 1).to_upper()

	var portrait := PanelContainer.new()
	portrait.custom_minimum_size = Vector2(110, 110)
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.set_border_width_all(0)
	style.border_color = accent
	style.set_corner_radius_all(20)
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


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()
