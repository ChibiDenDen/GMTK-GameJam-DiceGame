extends Control



var prev_size = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if size != prev_size:
		$SubViewport.size = size / 4
		$Sprite2D.texture = $SubViewport.get_texture()
		# fixes fullscreen-toggle bug
		$Sprite2D.flip_h = false
		$SubViewport/Game/UIViewport.scale = size.x/320 * Vector2.ONE * 0.1

func _ready():
	set_process_input(true)

func _input(event: InputEvent):
	$SubViewport.push_input(event.xformed_by(Transform2D(0, Vector2.ONE/4, 0, Vector2.ZERO)), true)
