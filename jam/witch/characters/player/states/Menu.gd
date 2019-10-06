extends "res://utilities/State.gd"
const Updates = preload("Updates.gd") # Relative path
var Items = load("res://inventory/Items.gd")

#onready var InventoryItemTemplate = preload("res://InventoryTest.tscn")
onready var invtest = preload("res://inventory/Inventory.tscn")

var inventory
var canvas
var itemlist
var player

var instance

func enter():
	.enter()
	
	canvas = get_node("../../../Canvas")

	# if we don't already have a menu instance we need to create one
	if not instance:
		instance = invtest.instance()
		canvas.add_child(instance)
		print("created menu instance")
	
	print("Menu")
	instance.visible = true
	instance.refresh_items()



func update():
	if Updates.check_menu():
		instance.visible = false
		emit_signal("change_state", "idle")

