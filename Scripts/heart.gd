extends Node2D

@onready var heart_sound = $heart_sound

func _on_area_2d_body_entered(body):
	if body.has_method("is_player"):
		GameManager.health += GameManager.heart
		heart_sound.play()
		await get_tree().create_timer(1).timeout
		queue_free()
