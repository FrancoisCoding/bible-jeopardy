extends RefCounted
class_name AudioController

var music_player: AudioStreamPlayer
var question_music_player: AudioStreamPlayer
var sfx_correct_player: AudioStreamPlayer
var sfx_wrong_player: AudioStreamPlayer
var sfx_select_player: AudioStreamPlayer
var music_slider: HSlider
var tween_owner: Node

var music_volume_tween: Tween = null
var background_stream: AudioStream
var question_stream: AudioStream
var correct_stream: AudioStream
var wrong_stream: AudioStream
var select_stream: AudioStream


func _init(
	owner: Node,
	music_player: AudioStreamPlayer,
	question_music_player: AudioStreamPlayer,
	sfx_correct_player: AudioStreamPlayer,
	sfx_wrong_player: AudioStreamPlayer,
	sfx_select_player: AudioStreamPlayer,
	music_slider: HSlider
) -> void:
	tween_owner = owner
	self.music_player = music_player
	self.question_music_player = question_music_player
	self.sfx_correct_player = sfx_correct_player
	self.sfx_wrong_player = sfx_wrong_player
	self.sfx_select_player = sfx_select_player
	self.music_slider = music_slider


func configure_streams(
	background: AudioStream,
	question: AudioStream,
	correct: AudioStream,
	wrong: AudioStream,
	select: AudioStream
) -> void:
	background_stream = background
	question_stream = question
	correct_stream = correct
	wrong_stream = wrong
	select_stream = select

	if music_player:
		music_player.stream = background_stream
		if music_player.stream:
			music_player.stream.loop = true

	if question_music_player:
		question_music_player.stream = question_stream
		if question_music_player.stream:
			question_music_player.stream.loop = true
		question_music_player.stop()

	if sfx_correct_player:
		sfx_correct_player.stream = correct_stream
	if sfx_wrong_player:
		sfx_wrong_player.stream = wrong_stream
	if sfx_select_player:
		sfx_select_player.stream = select_stream


func sync_slider_from_bus() -> void:
	if music_slider == null:
		return
	var bus_idx := AudioServer.get_bus_index("Master")
	var db := AudioServer.get_bus_volume_db(bus_idx)
	var half := (music_slider.min_value + music_slider.max_value) * 0.5
	music_slider.value = clamp(
		float(db if db != 0 else half), music_slider.min_value, music_slider.max_value
	)


func set_music_volume_db(target_db: float) -> void:
	var bus_idx := AudioServer.get_bus_index("Master")
	var current_db := AudioServer.get_bus_volume_db(bus_idx)
	if music_volume_tween and is_instance_valid(music_volume_tween):
		music_volume_tween.kill()
	if tween_owner == null:
		AudioServer.set_bus_volume_db(bus_idx, target_db)
		return
	music_volume_tween = tween_owner.create_tween()
	music_volume_tween.tween_method(
		func(db: float) -> void: AudioServer.set_bus_volume_db(bus_idx, db),
		current_db,
		target_db,
		0.08
	)


func play_background_music() -> void:
	stop_question_music()
	if music_player and not music_player.playing:
		music_player.play()


func stop_background_music() -> void:
	if music_player and music_player.playing:
		music_player.stop()


func play_question_music() -> void:
	stop_background_music()
	if question_music_player and question_music_player.stream and not question_music_player.playing:
		question_music_player.play()


func stop_question_music() -> void:
	if question_music_player and question_music_player.playing:
		question_music_player.stop()


func begin_question_audio() -> void:
	play_question_music()


func end_question_audio() -> void:
	stop_question_music()
	play_background_music()


func play_correct_sfx() -> void:
	if sfx_correct_player and sfx_correct_player.stream:
		sfx_correct_player.stop()
		sfx_correct_player.play()


func play_wrong_sfx() -> void:
	stop_question_music()
	if sfx_wrong_player and sfx_wrong_player.stream:
		sfx_wrong_player.stop()
		sfx_wrong_player.play()
	play_question_music()


func play_select_sfx() -> void:
	if sfx_select_player and sfx_select_player.stream:
		sfx_select_player.stop()
		sfx_select_player.play()
