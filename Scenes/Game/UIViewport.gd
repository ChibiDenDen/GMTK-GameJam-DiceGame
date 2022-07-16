extends CanvasLayer

@onready var inventory = $Equipment
@onready var menu = $Menu

func pause_game():
	get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	$HPBar.visible = false

func resume_game():
	get_parent().process_mode = Node.PROCESS_MODE_ALWAYS
	$HPBar.visible = true

func toggle_inventory():
	inventory.visible = !inventory.visible
	if inventory.visible:
		pause_game()
	else:
		get_parent().find_child("Player").setup_items()
		resume_game()

func toggle_menu():
	menu.visible = !menu.visible
	if menu.visible:
		pause_game()
	else:
		resume_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not menu.visible:
		if Input.is_action_just_pressed("Inventory"):
			toggle_inventory()
	if not inventory.visible:
		if Input.is_action_just_pressed("Exit"):
			toggle_menu()
