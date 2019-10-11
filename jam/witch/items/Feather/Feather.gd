extends "res://inventory/Item.gd"

class_name Feather

var tex = preload("res://items/Feather/Feather.png")

func _init():
	id = 4
	item_name = "Feather"
	quantity = 0
	price = 5
	description = "It's... a bird-leaf."
	texture = tex