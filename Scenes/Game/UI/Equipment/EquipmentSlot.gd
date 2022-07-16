extends Control

@export var number: int = 1

var equipped_item = null

@onready var sides = [
	$MarginContainer/Control/MarginContainer/CenterContainer/One,
	$MarginContainer/Control/MarginContainer/CenterContainer/Two,
	$MarginContainer/Control/MarginContainer/CenterContainer/Three,
	$MarginContainer/Control/MarginContainer/CenterContainer/Four,
	$MarginContainer/Control/MarginContainer/CenterContainer/Five,
	$MarginContainer/Control/MarginContainer/CenterContainer/Six]

# Called when the node enters the scene tree for the first time.
func _ready():
	sides[number - 1].visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_item(item_name):
	equipped_item = item_name
	var icon = load("res://Scenes/Game/Items/%s/Icon.png" % item_name)
	$MarginContainer/CenterContainer2/TextureRect.texture = icon
	$MarginContainer/Control/MarginContainer.scale = Vector2.ONE * 0.4

func unequip():
	equipped_item = null
	
	$MarginContainer/CenterContainer2/TextureRect.texture = null
	$MarginContainer/Control/MarginContainer.scale = Vector2.ONE
