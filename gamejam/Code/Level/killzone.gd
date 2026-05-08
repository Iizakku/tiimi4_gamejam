extends Area2D

# This detects when an enemy falls off a lower level and eliminates the enemy

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("Enemy has fallen")

		if body.has_method("die"):
			body.die(false, false)
