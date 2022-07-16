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
	"Wings": preload("res://Scenes/Game/Items/Wings/Wings.tscn"),
}

const bullet_class = preload("res://Scenes/Game/Enemies/ShooterDie/Bullet.gd")
const zombie_class = preload("res://Scenes/Game/Enemies/ZombieDie/ZombieDie.gd")

signal health_changed
signal max_health_set

var jump_allowed = true
var is_on_ground = false
var curr_jump = 0
var hp = 10

const jump_force = 7
const max_torque = 7

var was_on_ground = true

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_items()
	emit_signal("max_health_set", hp, true)

func allow_jump():
	jump_allowed = true

var movement_sounds = [
	load("res://Scenes/Game/Player/SFX/Movement/collision_wood_soft_01.wav"),
	load("res://Scenes/Game/Player/SFX/Movement/collision_wood_soft_02.wav"),
]

func play_movement_sound():
	$MovementAudioPlayer.stream = movement_sounds[randi() % movement_sounds.size()]
	$MovementAudioPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_move()

	var is_on_ground = test_move(transform, Vector3.DOWN*0.25)
	if is_on_ground and not was_on_ground:
		play_movement_sound()
	was_on_ground = is_on_ground

	_handle_jump()
	_handle_hits()
	

func _handle_move():
	var boots = find_child("Boots", true, false)
	var forward := global_position - camera.global_position
	forward.y = 0
	var max_force = max_torque * (boots.speed if boots else 1) - angular_velocity.length()
	forward = forward.normalized()
	var force_origin = global_position + Vector3.UP * 2 - global_position
	var force = Vector3.ZERO
	if Input.is_key_pressed(KEY_W):
		force += forward
	if Input.is_key_pressed(KEY_S):
		force += -forward
	if Input.is_key_pressed(KEY_D):
		force += -forward.rotated(Vector3.UP, deg2rad(90))
	if Input.is_key_pressed(KEY_A):
		force += forward.rotated(Vector3.UP, deg2rad(90))

	apply_force(force * max_force, force_origin)
	
func _handle_hits():
	for body in $BulletCollectArea.get_overlapping_bodies():
		if body is bullet_class:
			body.queue_free()
		elif body is zombie_class and body.can_attack:
			body.disable_attack()
		else:
			return
		print_debug("HIT hp = ", hp)
		hp -= 1
		emit_signal("health_changed", hp)
		
	if hp <= 0:
		# End game screen
		queue_free()
		get_tree().change_scene_to(load("res://Scenes/main_menu.tscn"))
		
func _handle_jump():
	var wings = find_child("Wings", true, false)
	var max_jumps_allowed = 1 + wings.additional_jumps if wings else 1
	if jump_allowed:
		var is_on_ground = test_move(transform, Vector3.DOWN*0.25)
		if is_on_ground:
			curr_jump = 0
		if Input.is_action_just_pressed("Jump") and (curr_jump < max_jumps_allowed):
			curr_jump += 1
			apply_impulse(Vector3.UP*jump_force)
			jump_allowed = false
			var tween = create_tween()
			tween.tween_interval(0.5)
			tween.tween_callback(allow_jump)
			
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
