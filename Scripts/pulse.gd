extends Area2D

var damage = GameManager.pulse_damage
var lifetime: float = 0.3

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $LifetimeTimer

func _ready():
	if GameManager.oil >= 5:
		GameManager.oil -= GameManager.pulse_cost
	for body in get_overlapping_bodies():
		if body.has_method("hit"):
			body.hit(damage)
	timer.wait_time = lifetime
	timer.start()
	
func _on_lifetime_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.has_method("hit") and body.has_method("is_player") == false:
		body.hit(damage)
