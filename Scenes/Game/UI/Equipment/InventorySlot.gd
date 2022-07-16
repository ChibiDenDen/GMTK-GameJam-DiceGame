extends Control

@export var item : String = ""

func setup():
	if item == "":
		modulate = Color.GRAY
		return
	var icon = load("res://Scenes/Game/Items/%s/Icon.png" % item)
	$ColorRect/CenterContainer/TextureRect.texture = icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
