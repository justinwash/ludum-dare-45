extends Node2D


var items = []

var player
var inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	inventory = player.get_node("Inventory")

func interact():
	var carried = player.get_node("CarriedItem")
	if carried.current_item:
		if not items.has(carried.current_item):
			items.append(carried.current_item)
			inventory.remove_item_by_name(carried.current_item.item_name)
			carried.current_item = null
			carried.visible = false
			$Item1Sprite.set_texture(items.back().texture)