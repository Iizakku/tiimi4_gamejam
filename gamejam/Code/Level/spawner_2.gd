extends Node2D
class_name spawner2


@export var enemy_2_scene : PackedScene


func _on_timer_timeout() -> void:
	var enemy_2 = enemy_2_scene.instantiate()
	enemy_2.position = position
	get_parent().add_child(enemy_2)
