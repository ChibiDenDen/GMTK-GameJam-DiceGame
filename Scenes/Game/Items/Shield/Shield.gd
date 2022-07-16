extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for projectile in $CSGCombiner3D/Area3D.get_overlapping_bodies():
		projectile.queue_free()

func setup(power):
	scale = Vector3.ONE * (0.5 + power*0.25)
