class_name Coin extends Collectable

@export var _score: int = 10
@onready var coin_sound: AudioStreamPlayer2D = $CoinSound

func collect(player : Player) -> bool:
	if not super.collect(player):
		return false
	# Disconnect the sound from the coin so it doesn't get deleted
	remove_child(coin_sound)
	get_tree().root.add_child(coin_sound)
	
	# Play the sound and set it to delete itself when finished
	coin_sound.global_position = global_position
	coin_sound.play()
	coin_sound.finished.connect(coin_sound.queue_free)		
		
	GameManager.add_score(_score)
	
	return true 
