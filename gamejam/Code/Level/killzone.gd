extends Area2D

# Tämä tunnistaa kun vihollinen tippuu pois alatasolta ja poistaa vihollisen 

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("Enemy has fallen")

		if body.has_method("die"):
			body.die(false, false)
