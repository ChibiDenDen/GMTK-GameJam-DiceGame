extends Node3D

@onready var player : RigidDynamicBody3D = get_parent()

const attack_angular_velocity_threshold := 2.0

var attacking = false
var do_attack_check = true

func do_attack_check_enable():
	do_attack_check = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if do_attack_check:
		var angular_velocity = player.angular_velocity
		
		# TODO: remove my side rotation, should look like this, but I think this does not work!
		angular_velocity.x = 0
		
		attacking = player.angular_velocity.length() > attack_angular_velocity_threshold
		do_attack_check = false
		var tween = create_tween()
		tween.tween_interval(1.0)
		tween.tween_callback(do_attack_check_enable)
	$Trail.render = attacking

	if attacking:
		var enemies = $CSGBox3D/Area3D.get_overlapping_bodies()
		for enemy in enemies:
			enemy.queue_free()
