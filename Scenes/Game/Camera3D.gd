extends Camera3D

@onready var player = get_parent().find_child("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var last_look_at = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var position_target = ((global_position - player.global_position).normalized() * 8) + player.global_position
	position_target.y = 5
	global_position = global_position.lerp(position_target, 5*delta)
	
	var player_aabb : AABB = player.get_transformed_aabb()
	var target_look_at = player_aabb.position + player_aabb.size/2
	target_look_at.y = player_aabb.position.y
	target_look_at.y = snapped(target_look_at.y, 0.5)
	if last_look_at:
		target_look_at = last_look_at.lerp(target_look_at, delta)
	last_look_at = target_look_at
	look_at(target_look_at)
