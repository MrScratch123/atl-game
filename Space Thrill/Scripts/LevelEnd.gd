extends Area2D

export var isLast = false

onready var globals = get_node("/root/GlobalVars")
var already_collected = false

# change level
func _on_Level_End_body_entered(body):
	if body.is_in_group("Player") and not already_collected:
		_next_level()

func _next_level():
	$AnimationPlayer.play("Collected")
	globals._start_slowing()
	yield(globals, "time_stopped") 
	already_collected = true
	globals.parts_collected += 1
	if !isLast:
		get_node("/root/Main")._load_scene(str(get_node("/root/GlobalVars").current_level + 1), true)
	else:
		get_node("/root/Main")._load_scene("won", true)
func _ready():
	$AnimationPlayer.play("Wave")
	
