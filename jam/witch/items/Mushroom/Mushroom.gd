extends "res://inventory/Item.gd"

class_name Mushroom

var tex = preload("res://items/Mushroom/Mushroom.png")

func _init():
	id = 3
	item_name = "Mushroom"
	quantity = 0
	price = 5
	description = "Now I can fly around"
	texture = tex

