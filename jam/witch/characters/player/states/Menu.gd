extends "res://utilities/State.gd"
const Updates = preload("Updates.gd") # Relative path
var Items = load("res://inventory/Items.gd")

#onready var InventoryItemTemplate = preload("res://InventoryTest.tscn")
onready var invtest = preload("res://InventoryTest.tscn")

var inventory
var canvas
var itemlist
var player

var instance

func enter():
	.enter()
	
	# inventory = get_node("../../Inventory")
	canvas = get_node("../../../Canvas")
	# itemlist = get_node("../../../Canvas/Menu/ItemList")
	# player = get_node("../../../Player")

	# if we don't already have a menu instance we need to create one
	if not instance:
		instance = invtest.instance()
		canvas.add_child(instance)
		print("created menu instance")
	
	print("Menu")
	instance.visible = true



func update():
	if Updates.check_menu():
		instance.visible = false
		emit_signal("change_state", "idle")

#func recursive_show(node, b):
#	for child in node.get_children():
#		recursive_show(child, b)
#	if node.get("visible"):
#		node.visible = b
