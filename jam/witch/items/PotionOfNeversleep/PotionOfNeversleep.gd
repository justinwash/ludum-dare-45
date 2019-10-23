extends "res://inventory/Item.gd"

class_name PotionOfNeversleep

var tex = preload("res://items/PotionOfNeversleep/PotionOfNeversleep.png")

func _init():
	id = 61
	item_name = "Potion of Neversleep"
	quantity = 0
	price = 400
	description = "Never sleep again! You still get tired though..."
	texture = tex

