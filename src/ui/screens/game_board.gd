extends Control
class_name GameBoard

signal tile_pressed(tile_data: Dictionary, tile_index: int)
signal round_complete

const ACTIVE_CATEGORY_COUNT := 4
const ACTIVE_TILE_ROWS := 3
const ACTIVE_TILE_COUNT := ACTIVE_CATEGORY_COUNT * ACTIVE_TILE_ROWS

@onready var category_labels: Array[Label] = [
	$Content/VBoxContainer/HBoxCategoryContainer/CategoryPanel1/Label,
	$Content/VBoxContainer/HBoxCategoryContainer/CategoryPanel2/Label,
	$Content/VBoxContainer/HBoxCategoryContainer/CategoryPanel3/Label,
	$Content/VBoxContainer/HBoxCategoryContainer/CategoryPanel4/Label
]

@onready var player_name_labels: Array[Label] = [
	$Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label,
	$Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label,
	$Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label
]

@onready var player_money_labels: Array[Label] = [
	$Content/VBoxContainer/HBoxPlayerContainer/Player1Panel/VBoxContainer/VBoxContainer/Label2,
	$Content/VBoxContainer/HBoxPlayerContainer/Player2Panel/VBoxContainer/VBoxContainer/Label2,
	$Content/VBoxContainer/HBoxPlayerContainer/Player3Panel/VBoxContainer/VBoxContainer/Label2
]

@onready
var grid_container: GridContainer = $Content/VBoxContainer/MarginBoardContainer/GridGameContainer

var tile_entries: Array[Dictionary] = []
var tile_states: Array[Dictionary] = []
var answered_count: int = 0


func _ready() -> void:
	_collect_tiles()


func set_tiles_enabled(enabled: bool) -> void:
	for i in range(tile_entries.size()):
		var entry := tile_entries[i]
		var btn: BaseButton = entry.get("button") as BaseButton
		if btn:
			var answered := false
			if i < tile_states.size():
				answered = tile_states[i].get("answered", false)
			btn.disabled = (not enabled) or answered


func _collect_tiles() -> void:
	if grid_container == null:
		return
	tile_entries.clear()
	tile_states.clear()
	answered_count = 0
	var idx := 0
	for child in grid_container.get_children():
		if idx >= ACTIVE_TILE_COUNT:
			break
		if child == null or not (child is Node):
			continue
		var btn := (child as Node).get_node_or_null("Button") as BaseButton
		var lbl := (child as Node).get_node_or_null("Label") as Label
		if btn:
			var tile_index := idx
			btn.pressed.connect(func() -> void: _on_tile_pressed(tile_index))
			btn.disabled = false
		if lbl:
			lbl.text = ""
		tile_entries.append({"button": btn, "label": lbl})
		tile_states.append({})
		idx += 1

	# Disable any extra tiles beyond the active 12.
	var extra_idx := 0
	for child in grid_container.get_children():
		if extra_idx >= ACTIVE_TILE_COUNT:
			var extra_btn := (child as Node).get_node_or_null("Button") as BaseButton
			if extra_btn:
				extra_btn.disabled = true
			var extra_lbl := (child as Node).get_node_or_null("Label") as Label
			if extra_lbl:
				extra_lbl.text = ""
		extra_idx += 1


func bind_round(categories: Array) -> void:
	_set_category_names(categories)
	_bind_tiles_from_categories(categories)
	answered_count = 0


func _set_category_names(categories: Array) -> void:
	for i in range(category_labels.size()):
		var name := ""
		if i < categories.size():
			var cat: Variant = categories[i]
			if typeof(cat) == TYPE_DICTIONARY:
				name = str((cat as Dictionary).get("name", ""))
			else:
				name = str(cat)
		if category_labels[i]:
			category_labels[i].text = name


func set_players(players: Array) -> void:
	for i in range(player_name_labels.size()):
		var name := "Player %d" % (i + 1)
		var score := 0
		if i < players.size():
			var p := players[i] as Dictionary
			name = "A.I." if p.get("is_ai", false) else str(p.get("name", name))
			score = int(p.get("score", 0))
		if player_name_labels[i]:
			player_name_labels[i].text = name
		_update_player_money_label(i, score)


func update_player_score(player_index: int, score: int) -> void:
	_update_player_money_label(player_index, score)


func _update_player_money_label(idx: int, score: int) -> void:
	if idx < 0 or idx >= player_money_labels.size():
		return
	var money_label := player_money_labels[idx]
	if money_label:
		money_label.text = _format_money(score)


func _format_money(score: int) -> String:
	var abs_value: int = abs(score)
	var prefix := "$" if score >= 0 else "-$"
	return "%s%d" % [prefix, abs_value]


func _bind_tiles_from_categories(categories: Array) -> void:
	if grid_container == null:
		return
	var filled_indices: Array[int] = []
	for cat_idx in range(min(ACTIVE_CATEGORY_COUNT, categories.size())):
		var cat: Variant = categories[cat_idx]
		var values: Array = []
		if typeof(cat) == TYPE_DICTIONARY:
			values = (cat as Dictionary).get("values", [])
		elif typeof(cat) == TYPE_ARRAY:
			values = cat

		for row in range(ACTIVE_TILE_ROWS):
			var grid_index := (row * ACTIVE_CATEGORY_COUNT) + cat_idx
			if grid_index >= tile_entries.size():
				continue
			var entry := tile_entries[grid_index]
			var lbl: Label = entry.get("label") as Label
			var val_data: Dictionary = {}
			if row < values.size() and typeof(values[row]) == TYPE_DICTIONARY:
				val_data = values[row] as Dictionary
			var display_value: int = int(
				val_data.get("value", val_data.get("amount", val_data.get("points", 0)))
			)
			if lbl:
				lbl.text = str(display_value) if display_value != 0 else ""
				lbl.visible = true

			if grid_index >= tile_states.size():
				tile_states.resize(grid_index + 1)
			tile_states[grid_index] = {
				"category_index": cat_idx,
				"category_name":
				(cat as Dictionary).get("name", "") if typeof(cat) == TYPE_DICTIONARY else "",
				"value_index": row,
				"value": display_value,
				"data": val_data,
				"answered": false
			}
			filled_indices.append(grid_index)

			var btn: BaseButton = entry.get("button") as BaseButton
			if btn:
				btn.visible = true
				btn.disabled = false

	# Disable/clear any extra or unused tiles
	for i in range(tile_entries.size()):
		if i >= ACTIVE_TILE_COUNT or not filled_indices.has(i):
			var entry := tile_entries[i]
			var btn: BaseButton = entry.get("button") as BaseButton
			var lbl: Label = entry.get("label") as Label
			if btn:
				btn.disabled = true
				btn.visible = false
			if lbl:
				lbl.text = ""
				lbl.visible = false
			if i < tile_states.size():
				tile_states[i] = {"answered": true}


func _disable_unused_tiles_from(start_idx: int) -> void:
	for i in range(start_idx, tile_entries.size()):
		var entry := tile_entries[i]
		var btn: BaseButton = entry.get("button") as BaseButton
		var lbl: Label = entry.get("label") as Label
		if btn:
			btn.disabled = true
		if lbl:
			lbl.text = ""
		if i < tile_states.size():
			tile_states[i] = {"answered": true}


func _on_tile_pressed(tile_idx: int) -> void:
	if tile_idx < 0 or tile_idx >= tile_states.size():
		return
	var state := tile_states[tile_idx]
	if state.get("answered", false):
		return
	emit_signal("tile_pressed", state, tile_idx)


func mark_tile_answered(tile_idx: int) -> void:
	if tile_idx < 0 or tile_idx >= tile_states.size():
		return
	if tile_states[tile_idx].get("answered", false):
		return
	tile_states[tile_idx]["answered"] = true
	answered_count += 1
	var entry := tile_entries[tile_idx]
	var btn: BaseButton = entry.get("button") as BaseButton
	var lbl: Label = entry.get("label") as Label
	if btn:
		btn.disabled = true
		btn.visible = false
	if lbl:
		lbl.text = ""
		lbl.visible = false
	_check_round_complete()


func _check_round_complete() -> void:
	if answered_count >= min(ACTIVE_TILE_COUNT, tile_entries.size()):
		emit_signal("round_complete")


func get_tile_state(tile_idx: int) -> Dictionary:
	if tile_idx < 0 or tile_idx >= tile_states.size():
		return {}
	return tile_states[tile_idx]


func get_unanswered_tile_indices() -> Array[int]:
	var indices: Array[int] = []
	for i in range(tile_states.size()):
		if not tile_states[i].get("answered", false):
			indices.append(i)
	return indices
