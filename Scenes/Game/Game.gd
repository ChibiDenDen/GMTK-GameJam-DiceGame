extends Node3D

func _ready():
	Engine.target_fps = 60

func _process(delta):
	if $Enemies.find_child("Boss") == null:
		get_tree().change_scene("res://Scenes/YouWon/YouWon.tscn")



func _on_exit_3_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to(load("res://Scenes/main_menu.tscn"))


func _on_restart_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to(load("res://Scenes/LowResGame/GameLowRes.tscn"))
