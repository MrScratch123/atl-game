extends Node

export(PackedScene) var heartSprite

onready var globals = get_node("/root/GlobalVars")
onready var health_bar = $Health_Bar/Bar
onready var health_text = $Health_Bar/Bar/Text
onready var tween = $Tween
onready var player = get_parent().get_parent()

var animated_health 

func _ready():
	var x = 0
	for i in globals.lives:
		var heart = heartSprite.instance()
		$Hearts.add_child(heart)
		heart.position = Vector2(x, 0)
		x += 80
	health_bar.max_value = player.MaxHealth
	animated_health = 100
	health_bar.value = animated_health

# update health ui
func _on_Player_updateHealth(newHealth):
	health_text.text = str(newHealth)
	tween.interpolate_property(self, "animated_health", animated_health, newHealth, 0.6, 
								Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	$Health_Bar/AnimationPlayer.play("Health_Change")

func _process(delta):
	health_bar.value = animated_health
	$Part_Collected.text = "Parts Collected = " + str(globals.parts_collected)
	
