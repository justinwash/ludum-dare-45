extends "res://inventory/Item.gd"

class_name GreaterPotionOfMinorNarcolepsy

var tex = preload("res://items/GreaterPotionOfMinorNarcolepsy/GreaterPotionOfMinorNarcolepsy.png")

func _init():
	id = 53
	item_name = "Greater Potion of Minor Narcolepsy"
	quantity = 0
	price = 65
	description = "A powerful potion. Do not use while operating a motor vehicle."
	texture = tex

