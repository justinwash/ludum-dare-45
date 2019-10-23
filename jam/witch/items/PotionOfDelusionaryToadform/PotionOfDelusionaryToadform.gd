extends "res://inventory/Item.gd"

class_name PotionOfDelusionaryToadform
	
var tex = preload("res://items/PotionOfDelusionaryToadform/PotionOfDelusionaryToadform.png")

func _init():
	id = 58
	item_name = "Potion of Delusionary Toadform"
	quantity = 0
	price = 230
	description = "You definitely turn into a toad when you drink this - don't let anyone tell you otherwise."
	texture = tex

