extends CanvasLayer

func _ready():
	$CheckBox.pressed = get_node("/root/Music").playing
	

func _on_CheckBox_toggled(button_pressed):
	get_node("/root/Music").playing = button_pressed

func _on_Go_back_pressed():
	get_node("/root/Main")._load_scene("menu", true)

