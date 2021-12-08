extends KinematicBody2D

signal touchedEnemy(damage, direction)
signal updateHealth(newHealth)
signal on_player_death()

export var moveSpeed = 300
export var upGrv = 20
export var downGrv = 25
export var jumpSp = 600
export var MaxHealth = 100
export var maxJumps = 2

onready var health = MaxHealth
onready var globals = get_node("/root/GlobalVars")
onready var animation_player = $Sprite/AnimationPlayer
onready var damage_player_animation = $Sprite/DamagePlayerAnimation
onready var sprite = $Sprite

var jumpsLeft = 0
var isded : bool = false
var move : Vector2 = Vector2()
var recoil : Vector2;
var is_on_ground : bool = false
var already_played : bool = false

func _physics_process(delta):
	# handle x position and input
	move.x = 0
	if Input.is_action_pressed("left"):
		move.x = -1
	if Input.is_action_pressed("right"):
		move.x = 1
	move.x = move.x * moveSpeed;
	
	# handle y position and input
	if !is_on_ground:
		if move.y >= 0:
			move.y += downGrv
		else:
			move.y += upGrv
		if is_on_ceiling():
			move.y = 1
			recoil.y = 0
	else:
		move.y = 0
		jumpsLeft = maxJumps
	if Input.is_action_just_pressed("jump") && jumpsLeft > 0:
		$Jump.play()
		jumpsLeft -= 1
		move.y = -jumpSp
	
	# reduce recoil
	recoil = lerp(recoil, Vector2.ZERO, 0.1)
	
	# actually just move
	move_and_slide((move + recoil) * globals.time_scale,  Vector2(0, -1))
	
	# handle death and time
	if (health <= 0 && isded == false):
		isded = true
		_death()
		animation_player.play("Death")
	# animations
	if isded:
		return
	animation_player.playback_speed = globals.time_scale
	if (move != Vector2.ZERO):
		if move.x >= 1:
			if is_on_ground:
				animation_player.play("Walking")
				already_played = false
			sprite.flip_h = false
		elif move.x <= -1:
			if is_on_ground:
				animation_player.play("Walking")
				already_played = false
			sprite.flip_h = true
		if !is_on_ground && !already_played:
			already_played = true
			animation_player.play("Jump")
	else:
		if is_on_ground: 
			already_played = false
			animation_player.play("Idle")

# signal if touching ground (or not)
func _on_GroundCheck_update_grounded(is_grounded):
	is_on_ground = is_grounded


# signal if touched enemy
func _on_Player_touchedEnemy(damage, direction):
	if isded == false:
		if health - damage >= 0:
			health -= damage
		elif health - damage < 0:
			health = 0
	$Hurt.play()
	recoil = Vector2(direction * 1500, -1500)
	move.y = 0
	damage_player_animation.play("Damage")
	emit_signal("updateHealth", health)
	
# handle death frames
func _death():
	isded = true
	emit_signal("on_player_death")
	globals.lives -= 1
	globals._start_slowing()
	yield(globals, "time_stopped") 
	if globals.lives > 0:
		get_node("/root/Main")._load_scene(str(get_node("/root/GlobalVars").current_level), true)
	else:
		get_node("/root/Main")._load_scene("death", true)
		globals.lives = globals.max_lives
		globals.parts_collected = 0

func _ready():
	globals._normalize_time()
	
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("Lava"):
		_death()
		$Hurt.play()
		animation_player.play("Death")
		emit_signal("updateHealth", 0)
		damage_player_animation.play("Damage")
