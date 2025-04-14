extends Node

#player stats
const MAX_OIL = 50.0
var oil = MAX_OIL
const MAX_HEALTH = 100
var health = MAX_HEALTH
var dead = false

#wave stats
var wave: int = 0
var enemies_remaining: int = 0
var is_in_wave = true
signal start_wave(wave: int)

#pick-up stats
var oil_can = 25
var heart = 15

#cone
var can_cone = true
var is_coneing = false
var cone_cost = .5
var cone_damage = 2
#boost
var is_cone_boosting = false
var cone_boost_cost = 1
var cone_boost_damage = 4

#pulse
var can_pulse = true
var pulse_cost = 30
var pulse_damage = 10

func _process(_delta):
	if oil < 0:
		dead = true
	if dead == true and oil != -1000:
		get_tree().change_scene_to_file("res://Scenes/die_screen.tscn")
		oil = -1000
	if oil <= pulse_cost:
		can_pulse = false
	else:
		can_pulse = true
	if oil <= cone_cost:
		can_cone = false
	else:
		can_cone = true

func next_wave():
	wave += 1
	start_wave.emit(wave)
