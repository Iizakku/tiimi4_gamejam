extends CharacterBody2D
class_name enemy_3

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const speed = 50.0
var direction = Vector2.RIGHT
var can_hit = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is Player:
			GameManager.take_damage()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and can_hit:
		can_hit = false

		GameManager.take_damage()

		await get_tree().create_timer(0.5).timeout
		can_hit = true
