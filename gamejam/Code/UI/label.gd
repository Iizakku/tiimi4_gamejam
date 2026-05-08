extends Label

func _ready() -> void:
	# Original scores
	update_label(GameManager.get_score())
	
	
	GameManager.score_changed.connect(update_label)
	
func update_label(new_score: int) -> void:
	text = "SCORE: " + str(new_score)
