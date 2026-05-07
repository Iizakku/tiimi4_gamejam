extends Control

var _is_paused: bool = false

func _ready() -> void:
	set_paused(false) # piilottaa menun alussa

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(!_is_paused)

func set_paused(value: bool) -> void:
	_is_paused = value
	get_tree().paused = value
	visible = value

func _on_resume_pressed() -> void:
	set_paused(false)

func _on_main_menu_pressed() -> void:
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
