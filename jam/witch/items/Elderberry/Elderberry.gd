extends "res://inventory/Item.gd"

var tex = preload("res://items/Elderberry/Elderberry.png")

func _init():
	id = 0
	item_name = "Elderberry"
	quantity = 0
	price = 1
	description = "A berry that grows on bushes"
	texture = tex