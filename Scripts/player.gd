extends CharacterBody2D

@onready var player = $"."
@onready var sprite_2d = $Sprite2D
@onready var light = $PointLight2D
@onready var oil_timer = $OilTimer
@onready var animation_player = $AnimationPlayer
@onready var hit_sound = $HitSound
@onready var cone_light = $Cone/ConeLight
@onready var cone_timer = $ConeTimer
@onready var cone_area = $Cone/ConeLight/Area2D
@onready var cone = $Cone


const SPEED = 12500
var pulse_scene = preload("res://Scenes/pulse.tscn")
signal lantern_pulse(pos)

func _physics_process(delta):
	var direction = Input.get_vector("Left","Right","Up","Down")
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity = Vector2.ZERO
	set_sprite_direction(direction)
	move_and_slide()

func _process(_delta):
	handle_cone()
	if light.enabled == false:
		GameManager.dead = true
	if GameManager.oil > 5:
		light.scale = Vector2(2, 2)
	elif GameManager.oil <= 5:
		light.scale = (2.0/5.0) * Vector2(GameManager.oil, GameManager.oil)
	if GameManager.health <= 0:
		animation_player.play("flame_out")
	if Input.is_action_just_pressed("Pulse") and GameManager.can_pulse:
		lantern_pulse.emit(player.global_position)

func handle_cone():
	#handle rotation
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	cone.rotation = direction.angle() - deg_to_rad(90)
	#stop cone if you run out of fuel
	if GameManager.can_cone == false:
		GameManager.is_coneing = false
		GameManager.is_cone_boosting = false
	#toggle cone
	if Input.is_action_just_pressed("Cone"):
		if GameManager.is_coneing:
			GameManager.is_coneing = false
		else:
			if GameManager.can_cone:
				GameManager.is_coneing = true
	#start payment timer
	if GameManager.is_coneing and cone_timer.is_stopped():
		cone_timer.start()
	#make cone turn on
	GameManager.is_cone_boosting = (GameManager.is_coneing and Input.is_action_pressed("Cone Boost", true))
	cone_light.enabled = GameManager.is_coneing
	cone_area.monitoring = GameManager.is_coneing
	#make the cone colour change if boosted
	if GameManager.is_coneing and !GameManager.is_cone_boosting:
		cone_light.color = Color(1.0, 0.5, 0.0, 1.0)
	elif GameManager.is_coneing and GameManager.is_cone_boosting:
		cone_light.color = Color(1.0, .8, 0.4, 1.0)

func set_sprite_direction(direction):
	if direction.x > 0:
		sprite_2d.play("right")
	elif direction.x < 0:
		sprite_2d.play("left")
	elif direction.y > 0:
		sprite_2d.play("down")
	elif direction.y < 0:
		sprite_2d.play("up")

func _on_oil_timer_timeout():
	if GameManager.oil > 0 and GameManager.is_in_wave:
		GameManager.oil -= 1
		oil_timer.start()
	elif GameManager.oil == 0:
		animation_player.play("flame_out")

func hit(hurt):
	hit_sound.play()
	GameManager.health -= hurt

func is_player():
	print("sup dude")

func _on_lantern_pulse(pos):
	var pulse = pulse_scene.instantiate() as Area2D
	pulse.position = pos
	$Pulses.add_child(pulse)


func _on_cone_timer_timeout():
	if GameManager.is_cone_boosting:
		if GameManager.is_in_wave:
			GameManager.oil -= GameManager.cone_boost_cost
	elif GameManager.is_coneing and !GameManager.is_cone_boosting:
		if GameManager.is_in_wave:
			GameManager.oil -= GameManager.cone_cost
	if GameManager.is_coneing and !GameManager.is_cone_boosting:
		for body in cone_area.get_overlapping_bodies():
			if body.has_method("hit") and !body.has_method("is_player"):
				body.hit(GameManager.cone_damage)
	elif GameManager.is_coneing and GameManager.is_cone_boosting:
		for body in cone_area.get_overlapping_bodies():
			if body.has_method("hit") and !body.has_method("is_player"):
				body.hit(GameManager.cone_boost_damage)
