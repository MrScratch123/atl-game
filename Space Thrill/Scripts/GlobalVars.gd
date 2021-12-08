extends Node

export var max_lives = 3

var current_level : int = 0;
var time_scale : float = 1;
var slowing = false
var parts_collected = 0

onready var lives : int = max_lives

signal time_stopped

func _process(delta):
	if slowing:
		_stop_time(delta)

func _stop_time(delta):
	time_scale = lerp(time_scale, 0, 5 * delta)
	if (time_scale <= 0.01):
		slowing = false
		emit_signal("time_stopped")

func _normalize_time():
	time_scale = 1
	slowing = false

func _start_slowing():
	slowing = true

	
