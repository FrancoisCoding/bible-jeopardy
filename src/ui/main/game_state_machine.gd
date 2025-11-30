extends RefCounted
class_name GameStateMachine

signal state_changed(old_state: int, new_state: int, payload: Dictionary)

# Flow:
# MAIN_MENU -> CONTROLLER_SETUP -> CHARACTER_SELECT -> ROUND_1 -> ROUND_1_TO_2_TRANSITION
# -> ROUND_2 -> FINAL_JEOPARDY_WAGER -> FINAL_JEOPARDY_QUESTION -> RESULTS
# PAUSED can overlay any state and will resume back to the previous one.
enum State {
	MAIN_MENU,
	CONTROLLER_SETUP,
	CHARACTER_SELECT,
	ROUND_1,
	ROUND_1_TO_2_TRANSITION,
	ROUND_2,
	FINAL_JEOPARDY_WAGER,
	FINAL_JEOPARDY_QUESTION,
	RESULTS,
	PAUSED
}

var current_state: int = State.MAIN_MENU
var previous_state: int = State.MAIN_MENU
var paused_from_state: int = State.MAIN_MENU


func bootstrap(state: int = State.MAIN_MENU, payload: Dictionary = {}) -> void:
	current_state = state
	previous_state = state
	paused_from_state = state
	emit_signal("state_changed", state, state, payload)


func transition_to(new_state: int, payload: Dictionary = {}, force_reenter: bool = false) -> void:
	if new_state == current_state and not force_reenter:
		return
	var old := current_state
	previous_state = old
	current_state = new_state
	emit_signal("state_changed", old, new_state, payload)


func pause(payload: Dictionary = {}) -> void:
	if current_state == State.PAUSED:
		return
	paused_from_state = current_state
	transition_to(State.PAUSED, payload)


func resume(payload: Dictionary = {}) -> void:
	if current_state != State.PAUSED:
		return
	transition_to(paused_from_state, payload)


func is_in_state(state: int) -> bool:
	return current_state == state


func is_in_any(states: Array) -> bool:
	for st in states:
		if current_state == st:
			return true
	return false


func name_for(state: int) -> String:
	match state:
		State.MAIN_MENU:
			return "MAIN_MENU"
		State.CONTROLLER_SETUP:
			return "CONTROLLER_SETUP"
		State.CHARACTER_SELECT:
			return "CHARACTER_SELECT"
		State.ROUND_1:
			return "ROUND_1"
		State.ROUND_1_TO_2_TRANSITION:
			return "ROUND_1_TO_2_TRANSITION"
		State.ROUND_2:
			return "ROUND_2"
		State.FINAL_JEOPARDY_WAGER:
			return "FINAL_JEOPARDY_WAGER"
		State.FINAL_JEOPARDY_QUESTION:
			return "FINAL_JEOPARDY_QUESTION"
		State.RESULTS:
			return "RESULTS"
		State.PAUSED:
			return "PAUSED"
		_:
			return "UNKNOWN"
