extends Node2D

@onready var left_portal: Area2D = $LeftPortal
@onready var right_portal: Area2D = $RightPortal

@onready var left_spawn: Marker2D = $LeftSpawn
@onready var right_spawn: Marker2D = $RightSpawn

var enemies_killed = 0

func _on_enemy_died(enemy):
	enemies_killed += 1

	print("Killed:", enemies_killed)
	print("Enemy was:", enemy.name)

	if enemies_killed >= 15:
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
	
	

func turn_sprite(body: Node2D, flip: bool) -> void:
	for child in body.get_children():
		if child is Sprite2D or child is AnimatedSprite2D:
			child.flip_h = flip
			break

func _on_left_portal_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body.is_in_group("enemies"):
		# Otetaan valmis sijainti Marker2D-pisteestä oikealta puolelta
		var target_position = right_spawn.global_position
		var new_position = Transform2D(body.global_transform.get_rotation(), target_position)
		
		PhysicsServer2D.body_set_state(body.get_rid(),PhysicsServer2D.BODY_STATE_TRANSFORM, new_position)
		
		body.linear_velocity.x = -abs(body.linear_velocity.x)
		turn_sprite(body, true)


func _on_right_portal_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body.is_in_group("enemies"):
		var target_position = left_spawn.global_position
		var new_position = Transform2D(body.global_transform.get_rotation(), target_position)
		
		PhysicsServer2D.body_set_state(body.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, new_position)
		
		body.linear_velocity.x = abs(body.linear_velocity.x)
		turn_sprite(body, false)
