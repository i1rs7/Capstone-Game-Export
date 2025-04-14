extends Node2D

@onready var oil_sound = $OilSound


func _on_area_2d_body_entered(body):
	if body.has_method("is_player"):
		GameManager.oil += GameManager.oil_can
		oil_sound.play()


func _on_oil_sound_finished():
	queue_free()
