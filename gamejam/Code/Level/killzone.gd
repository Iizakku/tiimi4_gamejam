extends Area2D

# Tämä tunnistaa kun vihollinen tippuu pois alatasolta ja poistaa vihollisen 

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		print("Enemy has fallen")
