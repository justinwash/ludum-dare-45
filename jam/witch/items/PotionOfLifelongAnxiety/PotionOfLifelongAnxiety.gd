extends "res://inventory/Item.gd"

class_name PotionOfLifelongAnxiety

var tex = preload("res://items/PotionOfLifelongAnxiety/PotionOfLifelongAnxiety.png")

func _init():
	id = 59
	item_name = "Potion of Lifelong Anxiety"
	quantity = 0
	price = 330
	description = "I think I already drank this one."
	texture = tex

