extends Node

var id
var item_name
var quantity
var price
var description

func toggle_dialog(should_be_visible):
		self.get_node("Label").visible = should_be_visible