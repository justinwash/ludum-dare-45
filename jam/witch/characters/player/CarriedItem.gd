extends Sprite

onready var Items = preload("res://inventory/Items.gd")

var current_item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_current_item(item_name):
	var item_inst = Items.getInstanceOfItemByItemName(item_name)
	current_item = item_inst
	self.set_texture(item_inst.texture)

func set_visibility(b):
	self.visible = b
