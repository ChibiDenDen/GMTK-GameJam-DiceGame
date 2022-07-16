extends CanvasLayer

@onready var inventory = $Equipment

func toggle_inventory():
	inventory.visible = !inventory.visible
	if inventory.visible:
		get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	else:
		get_parent().process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory()
