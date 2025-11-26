extends Control
class_name TimerBar

signal timeout

@export var duration_seconds: float = 30.0

var time_left: float = 0.0
var running: bool = false
var debug_accum: float = 0.0


func _ready() -> void:
	print("TimerBar: _ready")

	custom_minimum_size = Vector2(600.0, 40.0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Always allowed to process, but we only tick when running = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(false)  # <- DO NOT auto-start

	visible = false
	time_left = duration_seconds
	queue_redraw()

	print("TimerBar: initialized, duration_seconds =", duration_seconds)


func restart(seconds: float = -1.0) -> void:
	# Hard reset to a full bar and start ticking
	if seconds > 0.0:
		duration_seconds = seconds
	time_left = duration_seconds
	running = true
	visible = true
	set_process(true)
	queue_redraw()
	print("TimerBar.restart() -> duration_seconds =", duration_seconds)


func stop() -> void:
	# Stop ticking, keep whatever time is left
	running = false
	set_process(false)
	queue_redraw()
	print("TimerBar.stop()")


func is_running() -> bool:
	return running


func set_time_left(seconds: float) -> void:
	if duration_seconds <= 0.0:
		time_left = 0.0
	else:
		time_left = clamp(seconds, 0.0, duration_seconds)
	queue_redraw()


func _process(delta: float) -> void:
	if not running:
		return

	time_left -= delta
	if time_left <= 0.0:
		time_left = 0.0
		running = false
		set_process(false)
		print("TimerBar: timeout reached, emitting signal")
		timeout.emit()

	queue_redraw()

	# Debug log ~every 0.5s so you can see the countdown in Output
	debug_accum += delta
	if debug_accum >= 0.5:
		debug_accum = 0.0
		print("TimerBar: time_left =", snapped(time_left, 0.1))


func _draw() -> void:
	var size: Vector2 = get_size()
	if size.x <= 0.0 or size.y <= 0.0:
		return

	# Background track
	var track_rect: Rect2 = Rect2(Vector2.ZERO, size)
	draw_rect(track_rect, Color(0, 0, 0, 0.2), true)

	if duration_seconds <= 0.0:
		return

	# Ratio of time left (0..1)
	var ratio: float = clamp(time_left / duration_seconds, 0.0, 1.0)

	# Shrink from BOTH SIDES toward center
	var fill_width: float = size.x * ratio
	if fill_width <= 0.0:
		return

	var x: float = (size.x - fill_width) * 0.5
	var bar_rect: Rect2 = Rect2(Vector2(x, 0.0), Vector2(fill_width, size.y))

	draw_rect(bar_rect, Color(0.2, 0.6, 1.0, 0.9), true)
