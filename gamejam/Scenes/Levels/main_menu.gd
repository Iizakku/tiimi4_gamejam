extends Control

@onready var help: Panel = $Help

# Called when the node enters the scene tree for the first time.
func _ready():
	help.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_startgame_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")


func _on_options_pressed() -> void:
	print("options pressed")
	help.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_button_pressed() -> void:
	_ready()
