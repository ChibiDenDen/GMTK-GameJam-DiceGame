extends RigidDynamicBody3D

@onready var camera : Camera3D = get_parent().find_child("Camera3D")

@onready var sides = [
	$Sides/One,
	$Sides/Two,
	$Sides/Three,
	$Sides/Four,
	$Sides/Five,
	$Sides/Six,
]

var item_scenes = {
	"Sword": preload("res://Scenes/Game/Items/Sword/Sword.tscn"),
	"Shield": preload("res://Scenes/Game/Items/Shield/Shield.tscn"),
	"Boots": preload("res://Scenes/Game/Items/Boots/Boots.tscn"),
}

signal health_changed
signal max_health_set

var jump_allowed = true
var max_jumps_allowed = 1
var curr_jump = 0
var hp = 10

const jump_force = 7
const max_torque = 7


# Called when the node enters the scene tree for the first time.
func _ready():
	setup_items()
	emit_signal("max_health_set", 10, true)


func allow_jump():
	jump_allowed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var boots = find_child("Boots", true, false)
	var forward := global_position - camera.global_position
	forward.y = 0
	var max_force = max_torque * (boots.speed if boots else 1) - angular_velocity.length()
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
		if is_on_ground:
			curr_jump = 0
		if Input.is_action_just_pressed("Jump") and (curr_jump < max_jumps_allowed or curr_jump == 0):
			curr_jump += 1
			apply_impulse(Vector3.UP*jump_force)
			jump_allowed = false
			var tween = create_tween()
			tween.tween_interval(0.5)
			tween.tween_callback(allow_jump)
		
	for bullet in $BulletCollectArea.get_overlapping_bodies():
		bullet.queue_free()
		print_debug("HIT hp = ", hp)
		hp -= 1
		emit_signal("health_changed", hp)
		
	if hp <= 0:
		# End game screen
		queue_free()
		get_tree().change_scene_to(load("res://Scenes/main_menu.tscn"))

func get_transformed_aabb() -> AABB:
	return $CSGBox3D.get_transformed_aabb()
	
func set_item(item_name, side_index):
	var side = sides[side_index]
	var item : Node3D = item_scenes[item_name].instantiate()
	side.add_child(item)
	item.setup(side_index + 1)

func setup_items():
	for side in sides:
		for child in side.get_children():
			side.remove_child(child)
	var i = -1
	for equipment in Inventory.equipment:
		i += 1
		if equipment == null:
			continue
		set_item(equipment, i)
