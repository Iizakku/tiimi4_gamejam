extends Node2D
class_name spawner


@export var enemy_scene : PackedScene


func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)
