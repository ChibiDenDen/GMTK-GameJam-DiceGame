extends RigidDynamicBody3D

@onready var camera : Camera3D = get_parent().find_child("Camera3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var jump_allowed = true
const jump_force = 7
const max_torque = 7

func allow_jump():
	jump_allowed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var forward := global_position - camera.global_position
	forward.y = 0
	var max_force = max_torque - angular_velocity.length()
	forward = forward.normalized() * max_force
	var force_origin = global_position + Vector3.UP * 2 - global_position
	if Input.is_key_pressed(KEY_W):
		apply_force(forward, force_origin)
	if Input.is_key_pressed(KEY_S):
		apply_force(-forward, force_origin)
	if Input.is_key_pressed(KEY_D):
		apply_force(-forward.rotated(Vector3.UP, deg2rad(90)), force_origin)
	if Input.is_key_pressed(KEY_A):
		apply_force(forward.rotated(Vector3.UP, deg2rad(90)), force_origin)
	
	if jump_allowed:
		var is_on_ground = test_move(transform, Vector3.DOWN*0.25)
		if is_on_ground and Input.is_action_just_pressed("Jump"):
			apply_impulse(Vector3.UP*jump_force)
			jump_allowed = false
			var tween = create_tween()
			tween.tween_interval(1.0)
			tween.tween_callback(allow_jump)
		
	for bullet in $BulletCollectArea.get_overlapping_bodies():
		bullet.queue_free()
		print_debug("HIT")

func get_transformed_aabb() -> AABB:
	return $CSGBox3D.get_transformed_aabb()
