extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(ready_set_go)

var rdy = false

func ready_set_go():
	rdy = true
	$CenterContainer/Label.text += "Press any key to go back to the main menu"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rdy:
		if Input.is_anything_pressed():
			get_tree().change_scene("res://Scenes/main_menu.tscn")
