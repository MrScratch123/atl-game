extends Node2D

signal _changed_scene
var _current_scene : Node2D
onready var _animations = $CanvasLayer/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	_load_scene("menu", false)
	
func _load_scene(level, play_anim):
	match level:
		"menu":
			_create_and_load("res://Scenes/Levels/Main_Menu.tscn", level, play_anim)
		"1":
			_create_and_load("res://Scenes/Levels/Level1.tscn", level, play_anim)
		"2":
			_create_and_load("res://Scenes/Levels/Level2.tscn", level, play_anim)
		"3":
			_create_and_load("res://Scenes/Levels/Level3.tscn", level, play_anim)
		"4":
			_create_and_load("res://Scenes/Levels/Level4.tscn", level, play_anim)
		"5":
			_create_and_load("res://Scenes/Levels/Level5.tscn", level, play_anim)
		"death":
			_create_and_load("res://Scenes/Levels/Death_Screen.tscn", level, play_anim)
		"settings":
			_create_and_load("res://Scenes/Levels/Settings.tscn", level, play_anim)
		"won":
			_create_and_load("res://Scenes/Levels/WonGame.tscn", level, play_anim)
		"story":
			_create_and_load("res://Scenes/Levels/Story.tscn", level, play_anim)

func _create_and_load(path, level, play_anim):
	if (play_anim):
		_animations.play("Close")
		yield(_animations, "animation_finished")
	if _current_scene != null:
		remove_child(_current_scene)
		_current_scene.queue_free()
	get_node("/root/GlobalVars").current_level = int(level)
	var instance = load(path).instance()
	_current_scene = instance
	emit_signal("_changed_scene")
	add_child(instance)
	if (play_anim):
		_animations.play("Open")
