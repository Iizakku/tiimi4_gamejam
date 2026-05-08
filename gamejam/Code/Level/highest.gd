extends Label

var base_text := ""

func _ready() -> void:
	base_text = text  
	
	update_label(GameManager.get_score())
	GameManager.score_changed.connect(update_label)

func update_label(_new_score: int) -> void:
	text = base_text + "HIGHEST SCORE: " + str(GameManager.high_score)
