extends Node3D

func _ready():
	Engine.target_fps = 60

func _process(delta):
	if $Enemies.get_child_count() == 0:
		get_tree().change_scene("res://Scenes/YouWon/YouWon.tscn")
