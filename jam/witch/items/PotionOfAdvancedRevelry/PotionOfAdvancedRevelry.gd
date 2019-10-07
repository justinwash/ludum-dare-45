extends "res://inventory/Item.gd"

var tex = preload("res://items/PotionOfAdvancedRevelry/PotionOfAdvancedRevelry.png")

func _init():
	id = 55
	item_name = "Potion of Advanced Revelry"
	quantity = 0
	price = 105
	description = "Good times are made with Potion of Advanced Revelry."
	texture = tex

