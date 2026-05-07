extends Panel

@onready var heart1: TextureRect = $HBoxContainer/Heart1
@onready var heart2: TextureRect = $HBoxContainer/Heart2
@onready var heart3: TextureRect = $HBoxContainer/Heart3

func _ready() -> void:
	# connect gamemanager signal
	GameManager.lives_changed.connect(_on_lives_changed)
	# this ensures the correct number of hearts is displayed at the beginning
	_on_lives_changed(GameManager.current_lives)

# this runs when lives change
func _on_lives_changed(lives: int) -> void:
		# show or hide hearts based on current lives
		heart1.visible = lives >= 1
		heart2.visible = lives >= 2
		heart3.visible = lives >= 3
