extends Node2D
class_name spawner


@export var enemy_scene : PackedScene
@export var max_enemies = 25
var current_enemies = 0


func _on_timer_timeout() -> void:
	if current_enemies >= max_enemies:
		return
		
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)
	var level = get_tree().current_scene
	enemy.died.connect(level._on_enemy_died)
	
	current_enemies += 1
