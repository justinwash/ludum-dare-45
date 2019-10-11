extends "res://inventory/Item.gd"

class_name PsychoticEpisodeInABottle

var tex = preload("res://items/PsychoticEpisodeInABottle/PsychoticEpisodeInABottle.png")

func _init():
	id = 62
	item_name = "Psychotic Episode in a Bottle"
	quantity = 0
	price = 1000
	description = "Why would Petunia even want this?"
	texture = tex

