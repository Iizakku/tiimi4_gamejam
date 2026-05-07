extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var has_double_jumped: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		has_double_jumped = false
	
	_update_animations()

	# Handle jump logic
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			perform_jump()
		elif not has_double_jumped:
			perform_jump()
			has_double_jumped = true

	var direction = Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func perform_jump(strength := JUMP_VELOCITY):
	velocity.y = strength
	jump_sound.play() 


func jump(strength := JUMP_VELOCITY):
	perform_jump(strength)
	
func _update_animations() -> void:
	if not is_on_floor():
		animated_sprite.play("jump")
	elif is_zero_approx(velocity.x):
		animated_sprite.play("idle")
	else: 
		animated_sprite.play("run")
