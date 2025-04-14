extends CanvasLayer

@onready var health_bar = $UI/VBoxContainer/Health/HealthBar
@onready var health_number = $UI/VBoxContainer/Health/HealthNumber
@onready var oil_bar = $UI/VBoxContainer/Oil/OilBar
@onready var oil_number = $UI/VBoxContainer/Oil/OilNumber
@onready var wave_label = $UI/VBoxContainer/WaveLabel
@onready var wave_prog_label = $UI/VBoxContainer/WaveProgLabel
@onready var calm_timer = $"../WaveManager/CalmTimer"

func _ready():
	oil_bar.max_value = GameManager.MAX_OIL
	health_bar.max_value = GameManager.MAX_HEALTH
	oil_number.text = str(GameManager.MAX_OIL)
	health_number.text = str(GameManager.MAX_HEALTH)

func _process(_delta):
	wave_label.text = "Wave: " + str(GameManager.wave)
	if GameManager.is_in_wave:
		wave_prog_label.text = "Enemies Left: " + str(GameManager.enemies_remaining)
	else:
		wave_prog_label.text = "Time Until Wave: " + str(int(calm_timer.time_left + 1))
	oil_bar.value = GameManager.oil
	health_bar.value = GameManager.health
	oil_number.text = str(int(GameManager.oil))
	health_number.text = str(int(GameManager.health))
