extends Camera3D

var last_look_at = null
var position_target = Vector3.ZERO

func _ready():
	position_target = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent().find_child("Player")
	if player == null:
		return
	
	var around_player :Vector3= ((position_target - player.global_position).normalized() * 8)
	if Input.is_action_just_pressed("RotateCameraLeft"):
		around_player = around_player.rotated(Vector3.UP, deg2rad(90))
	if Input.is_action_just_pressed("RotateCameraRight"):
		around_player = around_player.rotated(Vector3.UP, deg2rad(-90))
	position_target = around_player + player.global_position
	position_target.y = 6 + player.global_position.y
	global_position = global_position.lerp(position_target, 15*delta)
	
	var player_aabb : AABB = player.get_transformed_aabb()
	var target_look_at = player_aabb.position + player_aabb.size/2
	target_look_at.y = player_aabb.position.y
	target_look_at.y = snapped(target_look_at.y, 0.5)
	if last_look_at:
		target_look_at = last_look_at.lerp(target_look_at, 5*delta)
	last_look_at = target_look_at
	look_at(target_look_at + Vector3.UP * 2)
