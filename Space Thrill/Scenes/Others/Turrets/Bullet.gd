extends Area2D

var direction
var move_speed = 500
var already_hit = false

onready var globals = get_node("/root/GlobalVars")

func _ready():
	get_node("/root/Main").connect("_changed_scene", self, "_delete")

func _process(delta):
	position.x += move_speed * direction * delta * globals.time_scale


func _on_Area2D_body_entered(body):
	var _body = body as Node2D
	if (_body.is_in_group("Player") && !already_hit):
		_body.emit_signal("touchedEnemy", 30, direction)
		already_hit = true
	queue_free()

func _delete():
	queue_free()
