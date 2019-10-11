extends Sprite

class_name CarriedItem

var current_item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_current_item(item_name):
	if item_name != null:
		var item_inst = Items.getInstanceOfItemByItemName(item_name)
		current_item = item_inst
		self.set_texture(item_inst.texture)
		set_visibility(true)
	else:
		current_item = null
		self.set_texture(load("res://tiles/blank_16x16.png"))
		set_visibility(false)

func set_visibility(b):
	self.visible = b
