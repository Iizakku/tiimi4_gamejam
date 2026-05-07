extends Area2D

@export var freeze_duration: float = 5.0

func _on_body_entered(body: Node2D) -> void:
# Check if the thing that touched the box is the Player
	if body.is_in_group("player"):
		activate_freeze()
		# Add soundeffect here if time
		queue_free() # Remove the box so it can't be used twice

func activate_freeze():
	# Find every node in the "enemies" group
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	print("Löysin näin monta vihollista: ", all_enemies.size())
	
	for _enemy in all_enemies:
		# Check if the enemy has the freeze function before calling it
		if _enemy.has_method("freeze_enemy"):
			_enemy.freeze_enemy(freeze_duration)	
