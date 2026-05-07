extends RigidBody2D
class_name enemy

signal died(enemy)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var coin_scene: PackedScene
@onready var die_sound_2: AudioStreamPlayer2D = $DieSound2


const speed = 50.0
var direction = -1.0
var health = 1
var invulnerable = false
var dead = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state):
	if freeze:
		state.linear_velocity = Vector2.ZERO
		return
		
	var velocity = state.linear_velocity
	velocity.x = direction * speed
	state.linear_velocity = velocity


func _on_area_2d_body_entered(body):
	if body is Player:
		invulnerable = true  # IMPORTANT: prevents double trigger

		take_damage(1)
		body.jump()
		call_deferred("queue_free")
		
func _on_area_2d_2_body_entered(body):
	if invulnerable:
		return

	if body is Player:
		if body.velocity.y > 0:
			return
			
		GameManager.take_damage()

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health:", health)

	if health <= 0:
		die()

func die(give_score := true, drop_loot := true):
	print("Enemy died!") 
	if dead:
		return
	dead = true
	died.emit(self)

	var sound = die_sound_2
	remove_child(sound)
	get_parent().add_child(sound)
	sound.global_position = global_position
	sound.play()

	if give_score:
		GameManager.add_score(10)
	
	if drop_loot and coin_scene:
		var coin = coin_scene.instantiate()
		get_parent().add_child(coin)
		
		var spawn_pos = global_position + Vector2(randf_range(-50, 50), -30)

		spawn_pos.x = clamp(spawn_pos.x, 0, 512)
		spawn_pos.y = clamp(spawn_pos.y, 0, 400)

		coin.global_position = spawn_pos
		
		
	call_deferred("queue_free")

# Tällä pysäytetään vihollinen
func freeze_enemy(duration: float):
	print("Enemy freeze")	
	freeze = true 
	
	if animated_sprite_2d:
		animated_sprite_2d.pause()

	await get_tree().create_timer(duration).timeout

	if is_instance_valid(self):
		freeze = false
		if animated_sprite_2d:
			animated_sprite_2d.play()
