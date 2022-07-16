extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Inventory.connect("picked_up", show_item_picked_message)

func show_item_picked_message(item_name):
	text = "[center]You picked up a %s\npress TAB to equip in inventory[/center]" % item_name
	visible = true
	var tween = create_tween()
	tween.tween_interval(3.5)
	tween.tween_callback(hide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
