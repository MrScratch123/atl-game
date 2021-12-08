extends Node2D

func _ready():
	$Complete_anim.play("win_anim")


func _switch():
	$Part1.visible = false
	$Part2.visible = false
	$Part3.visible = false
	$Part4.visible = false
	$Part5.visible = false
	$Sapc.visible = true
