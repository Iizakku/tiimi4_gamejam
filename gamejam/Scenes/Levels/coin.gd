class_name Coin extends Collectable

@export var _score: int = 10

func collect(player : Player) -> bool:
	if not super.collect(player):
		return false
		
	GameManager.add_score(_score)
	
	return true 
