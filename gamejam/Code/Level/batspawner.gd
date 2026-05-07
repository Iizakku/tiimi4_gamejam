extends Node2D
class_name spawner3


@export var enemy_3_scene : PackedScene
@export var max_enemies = 50
var current_enemies = 0


func _on_timer_timeout() -> void:
	if current_enemies >= max_enemies:
		return
		
	var enemy_3 = enemy_3_scene.instantiate()
	enemy_3.position = position
	get_parent().add_child(enemy_3)

	current_enemies += 1
