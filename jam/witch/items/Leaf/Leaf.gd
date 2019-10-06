extends "res://inventory/Item.gd"

var tex = preload("res://items/Leaf/Leaf.png")

func _init():
	id = 0
	item_name = "Leaf"
	quantity = 0
	price = 1
	description = "Its... a leaf"
	texture = tex