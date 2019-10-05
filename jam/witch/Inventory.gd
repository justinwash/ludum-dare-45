extends Node

var Item = preload("res://Item.gd").new()

func _ready():
	add_child(Item.get_item_from_id(0))

func add_item(id):
	for item in get_children():
		if item.id == id:
			item.quantity += 1

func remove_item(id):
	for item in get_children():
		if item.id == id:
			if item.quantity > 0:
				item.quantity -= 1
