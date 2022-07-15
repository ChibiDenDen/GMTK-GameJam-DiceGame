extends RigidDynamicBody3D

const bullet_scene = preload("res://Scenes/Game/Enemies/ShooterDie/Bullet.tscn")

const bullet_velocity = 20.0

func find_player():
	return get_parent().get_parent().find_child("Player")
	
func _ready():
	prepare_fire()

func do_fire():
	var player = find_player()
	if player != null:
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.velocity = (player.global_position - global_position).normalized() * bullet_velocity
	prepare_fire()

func prepare_fire():
	var tween = create_tween()
	tween.tween_interval(1.0 + randf_range(0.0, 3.0))
	tween.tween_callback(do_fire)
