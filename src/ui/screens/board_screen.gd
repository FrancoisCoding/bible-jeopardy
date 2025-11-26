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
			"Connected controllers fill Player 2 and 3; remaining slots become AI.",
			"Controles conectados preenchem Jogador 2 e 3; vagas restantes viram IA."
		)
	)
	player_info_label.text = info


func build_teams(
	team_names: Array[String],
	team_scores: Array,
	team_score_labels: Array,
	team_cards: Array,
	scoreboard: HBoxContainer,
	t_func: Callable
) -> void:
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
			continue

		team_scores.append(0)

		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(260, 140)
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
		name_label.add_theme_font_size_override("font_size", 28)
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		var score_label := Label.new()
		score_label.text = t_func.call("Points: 0", "Pontos: 0")
		if theme_styler:
			theme_styler.apply_font_override(score_label, game_font)
			theme_styler.apply_body_color(score_label)
		score_label.add_theme_font_size_override("font_size", 26)
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		vbox.add_child(name_label)
		vbox.add_child(score_label)

		card.add_child(vbox)
		team_score_labels.append(score_label)
		team_cards.append(card)

		scoreboard.add_child(card)


func set_score_label(
	idx: int, team_scores: Array, team_score_labels: Array, t_func: Callable
) -> void:
	if idx < 0 or idx >= team_score_labels.size():
		return
	team_score_labels[idx].text = t_func.call("Points: %s", "Pontos: %s") % team_scores[idx]


func _clear_children(container: Node) -> void:
	if container == null or not is_instance_valid(container):
		return
	for child in container.get_children():
		child.queue_free()
