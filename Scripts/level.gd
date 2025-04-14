extends Node2D
@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
