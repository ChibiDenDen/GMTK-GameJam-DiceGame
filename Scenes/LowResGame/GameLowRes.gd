extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var prev_size = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if size != prev_size:
		$SubViewport.size = size / 4
		$Sprite2D.texture = $SubViewport.get_texture()
		# fixes fullscreen-toggle bug
		$Sprite2D.flip_h = false
