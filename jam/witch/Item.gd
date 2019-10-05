extends Node

var id
var item_name
var quantity
var price
var description

var types = {
	"Mushroom": load("res://items/Mushroom.gd")
}

func get_item_from_id(id):
	if id == 0:
		return self.types.Mushroom.new()