extends AnimatableBody3D

var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_interval(20.0)
	tween.tween_callback(queue_free)

func _process(delta):
	global_position += velocity*delta
