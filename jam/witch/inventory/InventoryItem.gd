extends Control

var item_list
var inventory
var selected = [1000]

func _ready():
	inventory = load("res://inventory/Inventory.gd")
	item_list = get_node("ItemList")
	item_list.add_item("Mushroom", load("res://items/Mushroom/Mushroom.png"))
	item_list.add_item("Leaf", load("res://items/Leaf/Leaf.png"))

func _physics_process(delta):
	var new_selected = item_list.get_selected_items()
	if(len(new_selected) > 0):
		if (new_selected[0] != selected[0]):
			selected = new_selected
			print(item_list.get_item_text(selected[0]))
