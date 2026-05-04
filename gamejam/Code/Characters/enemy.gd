extends RigidBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var coin_scene: PackedScene

const speed = 50.0
var direction = -1.0
var health = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * speed * delta


func _on_timer_timeout() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is Player:
		var y_delta = body.position.y - position.y
		print("y_delta: ", y_delta) 
		if (y_delta < 0 ):
			print("Destroy enemy")
			take_damage(1)  #Voi muokata kuinka paljon damagee vihollinen ottaa
			body.jump()
		else:
			print("Decrease players health")
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
		coin.global_position = global_position + Vector2(randf_range(-60, 60), -20) #Tässä voi muokata mihin kohtaan kolikko spawnaa
	else:
		print("coin_scene is not set!")
		
	call_deferred("queue_free")
