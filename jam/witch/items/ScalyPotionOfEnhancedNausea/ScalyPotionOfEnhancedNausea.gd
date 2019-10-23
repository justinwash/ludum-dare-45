extends "res://inventory/Item.gd"

class_name ScalyPotionOfEnhancedNausea

var tex = preload("res://items/ScalyPotionOfEnhancedNausea/ScalyPotionOfEnhancedNausea.png")

func _init():
	id = 56
	item_name = "Scaly Potion of Enhanced Nausea"
	quantity = 0
	price = 38
	description = "I'm not sure why anyone would drink this."
	texture = tex

