extends "res://inventory/Item.gd"

class_name TastyHealthPotion

var tex = preload("res://items/TastyHealthPotion/TastyHealthPotion.png")

func _init():
	id = 52
	item_name = "Tasty Health Potion"
	quantity = 0
	price = 40
	description = "Tasty, and improves health with essential nutrients and vitamins. Allegedly."
	texture = tex

