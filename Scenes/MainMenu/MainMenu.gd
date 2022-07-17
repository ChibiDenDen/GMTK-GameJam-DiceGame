extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_startgame_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to(load("res://Scenes/LowResGame/GameLowRes.tscn"))


func _on_exit_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to(load("res://Scenes/main_menu.tscn"))


func _on_about_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to(load("res://Scenes/About/About.tscn"))
