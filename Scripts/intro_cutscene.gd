extends Control
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var point_light_2d_2: PointLight2D = $PointLight2D2
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var fallen: Node2D = $CanvasLayer/FALLEN



func _process(delta: float) -> void:
	if camera_2d.get_screen_center_position() == Vector2(320,1480):
		await get_tree().create_timer(1).timeout
		point_light_2d.visible = false
		get_tree().change_scene_to_file("res://Scenes/intro_cutscene_2.tscn")
