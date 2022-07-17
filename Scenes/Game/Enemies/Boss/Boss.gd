extends RigidDynamicBody3D

var can_attack = true
var can_hit = true
var health = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func find_player():
	return get_parent().get_parent().find_child("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = find_player()
	if player == null:
		return
	
	var to_player = player.global_position - global_position
	var distance_to_player = to_player.length()
	if distance_to_player < 20:
		apply_force(to_player.normalized() * 2, to_local(global_position + Vector3.UP * 2))

func disable_attack():
	can_attack = false
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(reset_attack)
	
func reset_attack():
	can_attack = true

func allow_hit():
	can_hit = true
	can_attack = true
	if health <= 0:
		queue_free()

func hit():
	print(str(can_hit))
	if not can_hit:
		return
	can_hit = false
	can_attack = false
	health -= 1
	print(str(health))
	$AnimationPlayer.play("Damage")
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(allow_hit)
