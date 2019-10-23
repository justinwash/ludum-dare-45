extends Node

class_name Inventory

var Items = load("res://inventory/Items.gd")

var playerCollectedItems = []

func _ready():
	pass

func add_item_by_name(item_name):
	var shouldCreateItem = false

	if player_has_item_by_name(item_name):
		print("Player already had item")
		get_item_by_name(item_name).quantity += 1
	else:
		print("Player didn't have this item")
		_createItemEntryByName(item_name)
		

func player_has_item_by_name(item_name):
	for item in playerCollectedItems:
		if item.name == item_name:
			return true
	return false
	

func get_item_by_name(item_name):
	for item in playerCollectedItems:
		if item.name == item_name:
			return item
	return null
	
func _createItemEntryByName(itemName):
	var entry = {"name": itemName, "quantity": 1}
	playerCollectedItems.push_front(entry)
	return entry

func remove_item_by_name(item_name):
	for item in playerCollectedItems:
		if (item.name == item_name && item.quantity > 0):
			item.quantity -= 1

func print_collected_items():
	print("PRINTING ITEMS")
	for item in playerCollectedItems:
		print("**ITEM**")
		print(item.name)
		print(item.quantity)

func getItemsInInventory():
	return playerCollectedItems