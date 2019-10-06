extends Node2D

var id
var item_name
var quantity
var price
var description
var texture

func toggle_dialog(should_be_visible):
		self.get_node("Label").visible = should_be_visible
