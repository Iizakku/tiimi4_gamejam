extends Control

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
	
	
func _on_startgame_pressed() -> void:
	GameManager.reset()
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
