extends Node2D
class_name spawner2


@export var enemy_2_scene : PackedScene
@export var max_enemies = 12
var current_enemies = 0


func _on_timer_timeout() -> void:
	if current_enemies >= max_enemies:
		return
		
	var enemy_2 = enemy_2_scene.instantiate()
	enemy_2.position = position
	get_parent().add_child(enemy_2)
	var level = get_tree().current_scene
	enemy_2.died.connect(level._on_enemy_died)
	
	current_enemies += 1
