extends "res://inventory/Item.gd"

class_name CrunchyNaturePotion

var tex = preload("res://items/CrunchyNaturePotion/CrunchyNaturePotion.png")

func _init():
	id = 51
	item_name = "Crunchy Nature Potion"
	quantity = 0
	price = 20
	description = "Be in tune with nature, at the cost of bad mouth-feel."
	texture = tex

