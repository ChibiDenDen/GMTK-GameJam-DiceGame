extends Node


var unlocked_items = []

var equipment = [null,null,null,null,null,null]

signal reload

func pick_up(item_name):
	print("Picked up " + item_name)
	unlocked_items.append(item_name)
	emit_signal("reload")
