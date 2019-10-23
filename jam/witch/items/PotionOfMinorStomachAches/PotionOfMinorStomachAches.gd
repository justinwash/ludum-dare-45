extends "res://inventory/Item.gd"

class_name PotionOfMinorStomachAches

var tex = preload("res://items/PotionOfMinorStomachAches/PotionOfMinorStomachAches.png")

func _init():
	id = 50
	item_name = "Potion of Minor Stomach Aches"
	quantity = 0
	price = 20
	description = "This doesn't make me feel very well..."
	texture = tex

func consume():
	print(self.description)