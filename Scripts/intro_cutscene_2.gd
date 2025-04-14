extends Control

@onready var fallen = $FALLEN
var flickertime1 = 0.0
var flickertime2 = 0.0
@onready var flickering_light: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var oil: Sprite2D = $FALLEN/Oil


func _ready():
	fallen.hide()
	await get_tree().create_timer(1).timeout
	flickering_light.play()
	for i in 12:
		oil.position = Vector2(randf_range(100,1048),randf_range(50,500))
		oil.rotation_degrees = randf_range(0,360)
		flickertime1 = randf_range(0.05,0.25)
		flickertime2 = randf_range(0.05,0.25)
		fallen.show()
		await get_tree().create_timer(flickertime1).timeout
		fallen.hide()
		await get_tree().create_timer(flickertime2).timeout
	flickering_light.stop()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	
func _process(_delta):
	pass
		


	
