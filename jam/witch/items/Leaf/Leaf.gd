extends "res://inventory/Item.gd"

class_name Leaf

var tex = preload("res://items/Leaf/Leaf.png")

func _init():
	id = 2
	item_name = "Leaf"
	quantity = 0
	price = 1
	description = "It's... a leaf."
	texture = tex