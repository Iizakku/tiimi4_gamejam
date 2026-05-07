extends Label

func _ready() -> void:
	# Alkuperäiset scoret
	update_label(GameManager.get_score())
	
	
	GameManager.score_changed.connect(update_label)
	
func update_label(new_score: int) -> void:
	text = "Score: " + str(new_score)
