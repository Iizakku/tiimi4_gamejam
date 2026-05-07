extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")


	
func _on_startgame_pressed() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
