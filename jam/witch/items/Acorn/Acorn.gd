extends "res://inventory/Item.gd"

class_name Acorn

var tex = preload("res://items/Acorn/Acorn.png")

func _init():
	id = 0
	item_name = "Acorn"
	quantity = 0
	price = 1
	description = "This probably fell from a nearby tree"
	texture = tex
