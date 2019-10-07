extends Node2D

var player
var inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	inventory = player.get_node("Inventory")

func interact():
	var carried = player.get_node("CarriedItem")
	if carried.get("current_item"):
		var item = carried.current_item
		inventory.remove_item_by_name(item.item_name)
		player.add_money(item.price)
		carried.set_current_item(null)
		
func interactable_area_entered():
	pass

func interactable_area_exited():
	pass
