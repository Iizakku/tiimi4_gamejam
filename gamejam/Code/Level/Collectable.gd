class_name Collectable extends Area2D

var is_collected : bool = false

func _on_body_entered(body: Node2D) -> void:
	print("Something collided with a collectable")
	if body is Player:
		if not collect(body as Player):
			print("Collecting didn't succeed!")


func collect(_knight : Player) -> bool:
	if is_collected:
		# Esine on jo kerätty, ei mahdollisteta sen keräämistä uudelleen
		return false

#TODO Toista keräämiseen liittyvät efektit, kuten äänet ja partikkeli
#Merkitse esine kerätyksi ja poista se pelimaailmasta
	is_collected = true
	queue_free()
	return true
