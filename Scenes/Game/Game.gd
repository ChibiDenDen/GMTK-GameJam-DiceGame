extends Node3D

func _ready():
	Engine.target_fps = 60

func _process(delta):
	if $Enemies.find_child("Boss") == null:
		get_tree().change_scene("res://Scenes/YouWon/YouWon.tscn")

