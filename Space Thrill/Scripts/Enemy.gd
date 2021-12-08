extends KinematicBody2D


export var move_speed = 300

onready var raycast_down_left = $Raycasts/down_left
onready var raycast_down_right = $Raycasts/down_right
onready var raycast_left = $Raycasts/left
onready var raycast_right = $Raycasts/right
onready var animation_player = $Sprite/AnimationPlayer
onready var sprite = $Sprite
onready var globals = get_node("/root/GlobalVars")

var direction = 1
var isded = false

signal kill

# check if should change directions and move accordingly
func _physics_process(delta):
	if (direction == 1 and (not raycast_down_right.is_colliding() or raycast_right.is_colliding())):
		direction = -1
		sprite.flip_h = true
	if (direction == -1 and (not raycast_down_left.is_colliding() or raycast_left.is_colliding())):
		direction = 1
		sprite.flip_h = false
	animation_player.playback_speed = globals.time_scale
	move_and_slide(Vector2(move_speed * direction * globals.time_scale , 0))

# if touch player then tell him
func _on_Collision_body_entered(body):
	if isded:
		return
	var _body = body as Node2D
	if (_body.is_in_group("Player")):
		_body.emit_signal("touchedEnemy", 30, direction)

func _on_Enemy_kill():
	$Collision.monitoring = false
	animation_player.play("Death")

func _ready():
	animation_player.play("Walk")
	
