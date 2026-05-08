class_name Collectable extends Area2D

var is_collected : bool = false

func _on_body_entered(body: Node2D) -> void:
	print("Something collided with a collectable")
	if body is Player:
		if not collect(body as Player):
			print("Collecting didn't succeed!")


func collect(_knight : Player) -> bool:
	if is_collected:
		# The item has already been collected, it is not possible to collect it again
		return false

	is_collected = true
	queue_free()
	return true
