extends StaticBody2D

export(PackedScene) var bullet_scene
export var direction = 1

onready var startpoint = $bullet_start_point
onready var globals = get_node("/root/GlobalVars")

func _on_Timer_timeout():
	if globals.slowing:
		return
	$AnimationPlayer.play("Shoot")

func _shoot():
	var bullet = bullet_scene.instance()
	bullet.position = $bullet_start_point.global_position
	get_node("/root").add_child(bullet)
	bullet.direction = direction
	
