extends Control


@export var inventory_slots_grid : Control

@export var equipment_slots_grid : Control

var equipment_slots = []

var selected : Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for inventory_slot in inventory_slots_grid.get_children():
		inventory_slot.connect("gui_input", inventory_slot_gui, [inventory_slot])

	for equipment_slot in equipment_slots_grid.get_children():
		var equipment_slot_name : String = equipment_slot.name
		if equipment_slot_name.begins_with("Disabled"):
			continue
		equipment_slots.append(equipment_slot)
		equipment_slot.connect("gui_input", equipment_slot_gui, [equipment_slot])

func unequip(item_name):
	for equipment_slot in equipment_slots:
		if equipment_slot.equipped_item == item_name:
			equipment_slot.unequip()
	for inventory_slot in inventory_slots_grid.get_children():
		if inventory_slot.item == item_name:
			inventory_slot.modulate = Color.WHITE

func inventory_slot_gui(event, slot):
	if event is InputEventMouseButton and event.pressed:
		if slot.modulate == Color.GRAY:
			unequip(slot.item)
		if selected != null:
			selected.modulate = Color.WHITE
		if selected == slot:
			selected = null
			return
		
		slot.modulate = Color.RED
		selected = slot

func equip_item(invenotry_slot, equipment_slot):
	if equipment_slot.equipped_item != null:
		unequip(equipment_slot.equipped_item)
	equipment_slot.set_item(invenotry_slot.item)
	selected.modulate = Color.GRAY

func equipment_slot_gui(event, slot):
	if event is InputEventMouseButton and event.pressed:
		if selected != null:
			equip_item(selected, slot)
		selected = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
