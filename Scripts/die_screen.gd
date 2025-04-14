extends Control

@onready var animation_player = $AnimationPlayer
@onready var restart_label = $RestartLabel
@onready var start_sound = $StartSound
@onready var enemy_1: Sprite2D = $Enemies/enemy1
var flickertime1 = 0.0
var flickertime2 = 0.0
@onready var wave_label: Label = $WaveLabel

func _ready():
	death_screen()
	

func _process(_delta):
	if Input.is_action_just_pressed("Pulse"):
		start_sound.play()
		init()
		await get_tree().create_timer(.5).timeout
		get_tree().change_scene_to_file("res://Scenes/level.tscn")

func init():
	GameManager.oil = GameManager.MAX_OIL
	GameManager.health = GameManager.MAX_HEALTH
	GameManager.dead = false
	GameManager.wave = 0
	GameManager.enemies_remaining = 0
	GameManager.is_in_wave = true

func death_screen():
	animation_player.play("die_message_fade_in")
	wave_label.text = "on wave " + str(GameManager.wave)
