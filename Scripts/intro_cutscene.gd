extends Control
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var point_light_2d_2: PointLight2D = $PointLight2D2
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var fallen: Node2D = $CanvasLayer/FALLEN



func _process(delta: float) -> void:
	pass
		


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(1).timeout
	point_light_2d.visible = false
	get_tree().change_scene_to_file("res://Scenes/intro_cutscene_2.tscn")
