extends Node
var Mushroom = load("res://items/Mushroom.gd")

var id
var item_name
var price
var description

func get_item_from_id(id):
	if id == 0:
		var mush = get_parent().add_child(Mushroom.new())
		return mush