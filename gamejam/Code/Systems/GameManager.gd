extends Node

#Signals
#score_changed is triggered when the score changes
signal score_changed(new_score : int)
# signals if lives changed
signal lives_changed(current_lives : int)

func game_over():
	get_tree().change_scene_to_file("res://Scenes/Levels/game_over.tscn")

#Player's score in this session
var _score : int = 0
# Player's lives
var max_lives: int = 3
var current_lives: int = 3
var can_take_damage = true
#Players highest scores
var high_score : int = 0

@export var damage_cooldown = 0.5


func start_damage_cooldown():
	await get_tree().create_timer(damage_cooldown).timeout
	can_take_damage = true

func take_damage():
	if !can_take_damage:
		return
		
	can_take_damage = false
	
	current_lives -= 1
	lives_changed.emit(current_lives)
	# a slight delay on damage to prevent multiple hits at once
	start_damage_cooldown()
	# check if there are no lives left
	if current_lives <= 0:
		die()

func die():
	# fill lives back to full
	current_lives = max_lives
	lives_changed.emit(current_lives)

	game_over()

# score
func reset() -> void:
	set_score(0)

func add_score(amount: int) -> void:
	# Only a positive amount can be added to the score
	if amount > 0:
		set_score(_score + amount)
		if _score > high_score:
			high_score = _score
			save_high_score()

func get_score() -> int:
	return _score

func set_score(new_score : int) -> void:
	# validate the new_score before setting it
	_score = max(new_score, 0)
	# Emit a signal every time the score is updated.
	score_changed.emit(_score)

	print("Score: %s" % _score)
	
func save_high_score():
	var file = FileAccess.open("user://save.data", FileAccess.WRITE)
	file.store_var(high_score)

func load_high_score():
	if FileAccess.file_exists("user://save.data"):
		var file = FileAccess.open("user://save.data", FileAccess.READ)
		high_score = file.get_var()
