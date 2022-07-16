extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_startgame_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to(load("res://Scenes/Game/Game.tscn"))


func _on_exit_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().quit()
