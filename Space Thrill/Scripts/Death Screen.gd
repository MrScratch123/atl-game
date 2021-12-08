extends CanvasLayer

func _ready():
	$Lose_jingle.play()

func _on_Button_pressed():
	get_node("/root/Main")._load_scene("menu", true)
