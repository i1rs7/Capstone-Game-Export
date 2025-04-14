extends Control

@onready var f = $Node2D/F
@onready var animation_player = $AnimationPlayer
@onready var start_sound = $StartSound
var flickertime1 = 0.0
var flickertime2 = 0.0
@onready var flickering_light: AudioStreamPlayer2D = $FlickeringLight
@onready var a: Label = $Node2D/A
@onready var l: Label = $Node2D/L
@onready var l_2: Label = $Node2D/L2
@onready var e: Label = $Node2D/E
@onready var n: Label = $Node2D/N

func _ready():
	flickering_light.play()
	for i in 20:
		flickertime1 = randf_range(0.05,0.3)
		flickertime2 = randf_range(0.1,0.5)
		f.hide()
		await get_tree().create_timer(flickertime1).timeout
		f.show()
		await get_tree().create_timer(flickertime2).timeout
	
	
func _process(_delta):
	pass
		


func _on_start_button_pressed() -> void:
	start_sound.play()
	#get_tree().change_scene_to_file("res://Scenes/intro_cutscene.tscn")
	#for debug:
	get_tree().change_scene_to_file("res://Scenes/intro_cutscene.tscn")
