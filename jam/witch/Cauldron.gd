extends Node2D


var item1
var item2

var player
var inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	inventory = player.get_node("Inventory")

func interact():
	var carried = player.get_node("CarriedItem")
	if carried.current_item:
		if not item1:
			item1 = carried.current_item
			inventory.remove_item_by_name(carried.current_item.item_name)
			carried.current_item = null
			carried.visible = false
			$Item1Sprite.set_texture(item1.texture)
		elif item1.id != carried.current_item.id:
			item2 = carried.current_item
			inventory.remove_item_by_name(carried.current_item.item_name)
			carried.current_item = null
			carried.visible = false
			$Item2Sprite.set_texture(item2.texture)
