extends Node2D
class_name spawner2


@export var enemy_2_scene : PackedScene
@export var max_enemies = 5
var current_enemies = 0


func _on_timer_timeout() -> void:
	if current_enemies >= max_enemies:
		return
		
	var enemy_2 = enemy_2_scene.instantiate()
	enemy_2.position = position
	get_parent().add_child(enemy_2)
	
	current_enemies += 1
