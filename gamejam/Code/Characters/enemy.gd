extends RigidBody2D
class_name enemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var coin_scene: PackedScene


const speed = 50.0
var direction = -1.0
var health = 1
var dead = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state):
	var velocity = state.linear_velocity
	velocity.x = direction * speed
	state.linear_velocity = velocity
	


func _on_area_2d_body_entered(body):
	if body is Player:
		dead = true  # IMPORTANT: prevents double trigger

		take_damage(1)
		body.jump()
		call_deferred("queue_free")
		
func _on_area_2d_2_body_entered(body):
	if dead:
		return

	if body is Player:
		GameManager.take_damage()

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health:", health)

	if health <= 0:
		die()

func die():
	print("Enemy died!")

	if coin_scene:
		var coin = coin_scene.instantiate()
		get_parent().add_child(coin)
		coin.global_position = global_position + Vector2(randf_range(-100, 100), -50) #Tässä voi muokata mihin kohtaan kolikko spawnaa
	else:
		print("coin_scene is not set!")
		
	call_deferred("queue_free")
