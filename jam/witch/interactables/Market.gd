extends Node2D

class_name Market

export(NodePath) var DIALOG_REF

var player
var inventory
var inventory_ui
var dialog_ref

export var dialog_sequence = []
var dialog_flags


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_ref = get_node(DIALOG_REF)
	player = get_node("../Player")
	inventory = player.get_node("Inventory")
	inventory_ui = get_tree().get_root().get_node("Main/Canvas/InventoryUI")

	dialog_flags = [false, false, false]

func interact():
	var carried = player.get_node("CarriedItem")
	if not carried.get("current_item") && dialog_flags == [true, true, true]:
		dialog_flags = [false, false, false]

	if not dialog_flags[0]:
		dialog_ref.text_box.set_text(dialog_sequence[1])
		dialog_ref.visible = true
		dialog_flags[0] = true
	elif not dialog_flags[1]:
		dialog_ref.text_box.set_text(dialog_sequence[2])
		dialog_flags[1] = true
	elif not dialog_flags[2]:
		dialog_ref.visible = false
		dialog_flags[2] = true


	if carried.get("current_item"):
		var item = carried.current_item
		inventory.remove_item_by_name(item.item_name)
		player.money += item.price
		carried.set_current_item(null)
		dialog_ref.text_box.set_text("Thanks!")

func interact_with_item(item):
	player.money += item.price
	inventory.remove_item_by_name(item.item_name)


func interactable_area_entered():
	var carried = player.get_node("CarriedItem")

	if not dialog_flags[0]:
		dialog_ref.text_box.set_text(dialog_sequence[0])
		dialog_ref.visible = true
	elif not dialog_flags[1]:
		dialog_ref.text_box.set_text(dialog_sequence[1])
		dialog_ref.visible = true
	elif not dialog_flags[2]:
		dialog_ref.text_box.set_text(dialog_sequence[2])
		dialog_ref.visible = true
	elif carried.get("current_item"):
		var item = carried.current_item
		var text = dialog_sequence[3] % [item.item_name, item.price]
		dialog_ref.text_box.set_text(text)
		dialog_ref.visible = true

	var inv_items = inventory_ui.get_inventory_items()
	for inv_item in inv_items:
		inv_item.set_button_text("Sell ($%d)" % inv_item.item_inst.price)



func interactable_area_exited():
	dialog_ref.visible = false
	inventory_ui.set_all_button_text("Carry")
