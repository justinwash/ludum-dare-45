extends Node
onready var Mushroom = load("res://items/Mushroom.gd")

var id
var item_name
var price
var description

func get_item_from_id(id):
	if id == 0:
		return Mushroom