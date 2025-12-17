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
var tile_buttons: Array[BaseButton] = []


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
	_setup_tile_focus_grid(ACTIVE_CATEGORY_COUNT)


func _find_first_button(node: Node) -> BaseButton:
	if node == null:
		return null
	if node is BaseButton:
		return node as BaseButton
	for child: Node in node.get_children():
		var found_button: BaseButton = _find_first_button(child)
		if found_button != null:
			return found_button
	return null


func _set_non_button_controls_ignore_mouse(root: Node, keep: BaseButton) -> void:
	# Optional but helps when decorative Controls are stealing clicks.
	if root == null:
		return
	if root is Control and root != keep:
		(root as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child: Node in root.get_children():
		_set_non_button_controls_ignore_mouse(child, keep)


func _collect_tiles() -> void:
	if grid_container == null:
		return
	tile_entries.clear()
	tile_states.clear()
	tile_buttons.clear()

	var found_count: int = 0
	var idx: int = 0

	for child: Node in grid_container.get_children():
		if idx >= ACTIVE_TILE_COUNT:
			break

		var btn: BaseButton = _find_first_button(child)

		if btn:
			found_count += 1
			var tile_index: int = idx

			btn.set_meta("tile_index", tile_index)
			btn.process_mode = Node.PROCESS_MODE_ALWAYS

			# Make sure the button can actually receive clicks.
			btn.mouse_filter = Control.MOUSE_FILTER_STOP
			btn.disabled = false
			btn.visible = true
			btn.focus_mode = Control.FOCUS_ALL

			# Prevent overlays/labels inside the tile from eating input.
			_set_non_button_controls_ignore_mouse(child, btn)

			# Connect once.
			if not bool(btn.get_meta("tile_pressed_connected", false)):
				btn.pressed.connect(Callable(self, "_on_tile_pressed_meta").bind(btn))
				btn.set_meta("tile_pressed_connected", true)

			btn.add_to_group("board_tiles")
			_debug_tile_button_ready(btn)

			# Clear any default text; values are set by bind_round().
			if btn is Button:
				(btn as Button).text = ""
		else:
			push_warning("No button found for tile slot: %s" % str(child.get_path()))

		tile_entries.append({"button": btn})
		tile_states.append({})
		tile_buttons.append(btn)
		idx += 1

	print("GameBoard tiles wired:", found_count, "/", ACTIVE_TILE_COUNT)
	_setup_tile_focus_grid(ACTIVE_CATEGORY_COUNT)

	# Disable any extra tiles beyond the active 12.
	var extra_idx: int = 0
	for child: Node in grid_container.get_children():
		if extra_idx >= ACTIVE_TILE_COUNT:
			var extra_btn: BaseButton = _find_first_button(child)
			if extra_btn:
				extra_btn.process_mode = Node.PROCESS_MODE_ALWAYS
				extra_btn.disabled = true
				extra_btn.visible = false
				if extra_btn is Button:
					(extra_btn as Button).text = ""
		extra_idx += 1


func bind_round(categories: Array) -> void:
	_set_category_names(categories)
	_bind_tiles_from_categories(categories)
	_setup_tile_focus_grid(ACTIVE_CATEGORY_COUNT)
	_check_round_complete()


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
			var btn: BaseButton = entry.get("button") as BaseButton
			var val_data: Dictionary = {}
			if row < values.size() and typeof(values[row]) == TYPE_DICTIONARY:
				val_data = values[row] as Dictionary
			var display_value: int = int(
				val_data.get("value", val_data.get("amount", val_data.get("points", 0)))
			)
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

			if btn:
				btn.visible = true
				btn.disabled = false
				if btn is Button:
					(btn as Button).text = str(display_value) if display_value != 0 else ""

	# Disable/clear any extra or unused tiles
	for i in range(tile_entries.size()):
		if i >= ACTIVE_TILE_COUNT or not filled_indices.has(i):
			var entry := tile_entries[i]
			var btn: BaseButton = entry.get("button") as BaseButton
			if btn:
				btn.disabled = true
				btn.visible = false
				if btn is Button:
					(btn as Button).text = ""
			if i < tile_states.size():
				tile_states[i] = {"answered": true}


func _disable_unused_tiles_from(start_idx: int) -> void:
	for i in range(start_idx, tile_entries.size()):
		var entry := tile_entries[i]
		var btn: BaseButton = entry.get("button") as BaseButton
		if btn:
			btn.disabled = true
			if btn is Button:
				(btn as Button).text = ""
		if i < tile_states.size():
			tile_states[i] = {"answered": true}


func _on_tile_pressed(tile_idx: int) -> void:
	print("tile pressed idx=", tile_idx, " states=", tile_states.size())
	if tile_idx < 0 or tile_idx >= tile_states.size():
		print(" -> blocked: idx out of range")
		return
	var state := tile_states[tile_idx]
	if state.get("answered", false):
		print(" -> blocked: already answered")
		return
	print(" -> emitting tile_pressed with state=", state)
	emit_signal("tile_pressed", state, tile_idx)


func mark_tile_answered(tile_idx: int) -> void:
	if tile_idx < 0 or tile_idx >= tile_states.size():
		return
	if tile_states[tile_idx].get("answered", false):
		return
	tile_states[tile_idx]["answered"] = true
	var entry := tile_entries[tile_idx]
	var btn: BaseButton = entry.get("button") as BaseButton
	if btn:
		btn.disabled = true
		btn.visible = false
		if btn is Button:
			(btn as Button).text = ""
	_setup_tile_focus_grid(ACTIVE_CATEGORY_COUNT)
	_check_round_complete()


func _is_focusable_tile_button(btn: BaseButton) -> bool:
	return btn != null and is_instance_valid(btn) and btn.visible and not btn.disabled


func _setup_tile_focus_grid(cols: int) -> void:
	if cols <= 0:
		return

	var n: int = tile_buttons.size()
	if n <= 0:
		return
	if n > ACTIVE_TILE_COUNT:
		n = ACTIVE_TILE_COUNT

	# Ensure focus mode is enabled for all tile buttons.
	for i in range(n):
		var btn: BaseButton = tile_buttons[i]
		if btn == null or not is_instance_valid(btn):
			continue
		btn.focus_mode = Control.FOCUS_ALL

	# Build deterministic d-pad neighbors (skips hidden/disabled tiles).
	for i in range(n):
		var btn: BaseButton = tile_buttons[i]
		if not _is_focusable_tile_button(btn):
			continue

		var r: int = i / cols
		var row_start: int = r * cols
		var row_end: int = row_start + cols - 1
		if row_end > (n - 1):
			row_end = n - 1

		var left_target: BaseButton = btn
		for j in range(i - 1, row_start - 1, -1):
			var cand: BaseButton = tile_buttons[j]
			if _is_focusable_tile_button(cand):
				left_target = cand
				break

		var right_target: BaseButton = btn
		for j in range(i + 1, row_end + 1):
			var cand: BaseButton = tile_buttons[j]
			if _is_focusable_tile_button(cand):
				right_target = cand
				break

		var up_target: BaseButton = btn
		for j in range(i - cols, -1, -cols):
			var cand: BaseButton = tile_buttons[j]
			if _is_focusable_tile_button(cand):
				up_target = cand
				break

		var down_target: BaseButton = btn
		for j in range(i + cols, n, cols):
			var cand: BaseButton = tile_buttons[j]
			if _is_focusable_tile_button(cand):
				down_target = cand
				break

		btn.focus_neighbor_left = left_target.get_path()
		btn.focus_neighbor_right = right_target.get_path()
		btn.focus_neighbor_top = up_target.get_path()
		btn.focus_neighbor_bottom = down_target.get_path()


func _check_round_complete() -> void:
	var limit: int = int(min(ACTIVE_TILE_COUNT, tile_states.size()))
	for i in range(limit):
		if not tile_states[i].get("answered", false):
			return
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


func _debug_tile_button_ready(btn: BaseButton) -> void:
	if btn == null:
		return
	print("Tile btn ready -> disabled:", btn.disabled, " paused:", get_tree().paused, " path:", btn.get_path())


func _on_tile_pressed_meta(btn: BaseButton) -> void:
	if btn == null or not is_instance_valid(btn):
		return
	var tile_idx := int(btn.get_meta("tile_index", -1))
	print("PRESSED:", btn.get_path())
	_on_tile_pressed(tile_idx)


func focus_first_available_tile() -> void:
	for i in range(tile_entries.size()):
		var entry := tile_entries[i]
		var btn: BaseButton = entry.get("button") as BaseButton
		var answered := false
		if i < tile_states.size():
			answered = tile_states[i].get("answered", false)
		if btn and not btn.disabled and not answered:
			btn.focus_mode = Control.FOCUS_ALL
			btn.grab_focus()
			return
