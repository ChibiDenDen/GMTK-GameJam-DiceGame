extends RigidDynamicBody3D

var positional_target := Vector3.ZERO
const force_power = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	choose_positional_target()

func choose_positional_target():
	positional_target = global_position + 5 * Vector3.ONE.rotated(Vector3.UP, randf_range(0.0, PI*2))
	var tween = create_tween()
	tween.tween_interval(5.0)
	tween.tween_callback(choose_positional_target)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var force = positional_target - global_position
	force.y = 0
	force = force.normalized() * force_power * delta
	apply_force(force)
