extends CanvasLayer

# load first level
func _on_Button_pressed():
	get_node("/root/Main")._load_scene("1", true)


func _on_Settings_pressed():
	get_node("/root/Main")._load_scene("settings", true)


func _on_Play_pressed():
	get_node("/root/Main")._load_scene("story", true)
