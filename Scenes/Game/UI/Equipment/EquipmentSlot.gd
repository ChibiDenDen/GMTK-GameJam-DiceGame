extends Control

@export var number: int = 1

@onready var sides = [
	$MarginContainer/CenterContainer/One,
	$MarginContainer/CenterContainer/Two,
	$MarginContainer/CenterContainer/Three,
	$MarginContainer/CenterContainer/Four,
	$MarginContainer/CenterContainer/Five,
	$MarginContainer/CenterContainer/Six]

# Called when the node enters the scene tree for the first time.
func _ready():
	sides[number - 1].visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
