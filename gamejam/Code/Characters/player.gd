extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -250.0

var has_double_jumped: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# reset double jump
		has_double_jumped = false
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal jump
			velocity.y = JUMP_VELOCITY
		elif not has_double_jumped:
			# Double jump
			velocity.y = JUMP_VELOCITY
			has_double_jumped = true

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#Tämä käsittelee hypyn vihollista tappaessa
func jump(strength := JUMP_VELOCITY):
	velocity.y = strength
