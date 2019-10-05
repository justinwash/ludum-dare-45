extends Node

var Items = load("res://Items.gd").new()

func _ready():
	for type in Items.types:
		add_child(Items.types[type])

func add_item_by_name(item_name):
	for item in get_children():
		if item.item_name == item_name:
			item.quantity += 1

func remove_item_by_name(item_name):
	for item in get_children():
		if item.item_name == item_name && item.quantity > 0:
			item.quantity -= 1
