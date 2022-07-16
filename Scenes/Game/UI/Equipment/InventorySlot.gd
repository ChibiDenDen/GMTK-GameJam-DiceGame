extends Control

@export var item : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon = load("res://Scenes/Game/Items/%s/Icon.png" % item)
	$ColorRect/CenterContainer/TextureRect.texture = icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
