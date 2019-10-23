extends "res://utilities/State.gd"

class_name Menu

const Updates = preload("Updates.gd") # Relative path
var Items = load("res://inventory/Items.gd")


var inventory
var canvas
var itemlist
var player

var menu

func enter():
	.enter()

	menu = get_tree().get_root().get_node("Main/Canvas/InventoryUI")

	print("Menu")
	menu.visible = !menu.visible
	menu.refresh_items()
	emit_signal("change_state", "idle")



func update():
	if Updates.check_menu():
		menu.visible = false
		emit_signal("change_state", "idle")

