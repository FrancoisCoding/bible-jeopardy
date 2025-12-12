extends RefCounted
class_name GameSessionState

static var players: Array[Dictionary] = []
static var scores: Array[int] = []


static func reset() -> void:
	players.clear()
	scores.clear()


static func set_players(new_players: Array[Dictionary], score_source: Array[int] = []) -> void:
	# Keep the existing array instances so any references stay valid.
	players.clear()
	players.resize(new_players.size())
	for i in range(new_players.size()):
		var entry := new_players[i]
		if typeof(entry) == TYPE_DICTIONARY:
			players[i] = (entry as Dictionary).duplicate(true)
		else:
			players[i] = {"name": str(entry)}
	_resize_scores(new_players.size())
	if score_source.is_empty():
		for i in range(scores.size()):
			scores[i] = 0
	else:
		set_scores(score_source)


static func set_scores(new_scores: Array[int]) -> void:
	_resize_scores(new_scores.size())
	for i in range(min(scores.size(), new_scores.size())):
		scores[i] = int(new_scores[i])


static func set_score(idx: int, value: int) -> void:
	_resize_scores(idx + 1)
	scores[idx] = value


static func add_score(idx: int, delta: int) -> int:
	_resize_scores(idx + 1)
	scores[idx] += delta
	return scores[idx]


static func get_player_card(idx: int) -> Dictionary:
	if idx < 0 or idx >= players.size():
		return {}
	var p: Dictionary = players[idx]
	var name := str(p.get("name", "Player %d" % (idx + 1)))
	var score := scores[idx] if idx < scores.size() else 0
	return {"name": name, "score": score, "is_ai": bool(p.get("is_ai", false))}


static func get_player_cards() -> Array[Dictionary]:
	var cards: Array[Dictionary] = []
	for i in range(players.size()):
		cards.append(get_player_card(i))
	return cards


static func _resize_scores(count: int) -> void:
	if count < 0:
		return
	scores.resize(count)
	for i in range(scores.size()):
		# Ensure every slot is initialized
		if typeof(scores[i]) != TYPE_INT:
			scores[i] = int(scores[i]) if scores[i] != null else 0
