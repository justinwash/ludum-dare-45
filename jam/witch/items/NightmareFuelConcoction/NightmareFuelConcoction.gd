extends "res://inventory/Item.gd"

class_name NightmareFuelConcoction

var tex = preload("res://items/NightmareFuelConcoction/NightmareFuelConcoction.png")

func _init():
	id = 60
	item_name = "Nightmare Fuel Concoction"
	quantity = 0
	price = 500
	description = "A potion that puts you to sleep AND gives you nightmares. Two for one!"
	texture = tex

