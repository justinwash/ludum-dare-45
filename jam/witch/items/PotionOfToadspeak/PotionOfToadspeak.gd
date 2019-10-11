extends "res://inventory/Item.gd"

class_name PotionOfToadspeak

var tex = preload("res://items/PotionOfToadspeak/PotionOfToadspeak.png")

func _init():
	id = 57
	item_name = "Potion of Toadspeak"
	quantity = 0
	price = 175
	description = "Lets you speak toad."
	texture = tex

