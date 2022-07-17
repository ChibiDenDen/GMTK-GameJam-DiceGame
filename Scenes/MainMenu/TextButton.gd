extends Button

var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = find_child("AnimationPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_hovered():
		if not animation_player.is_playing():
			animation_player.play("ScaleLoop")
	else:
		if animation_player.is_playing():
			animation_player.seek(0, true)
			animation_player.stop(true)
