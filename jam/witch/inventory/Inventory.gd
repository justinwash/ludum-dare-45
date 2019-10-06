extends Node

var Items = load("res://inventory/Items.gd")

var playerCollectedItems = []

func _ready():
	pass

func add_item_by_name(item_name):
	var shouldCreateItem = false

	for item in playerCollectedItems:
		if (item.name == item_name):
			item.quantity += 1
		else:
			shouldCreateItem = true
	if (playerCollectedItems.size() == 0 || shouldCreateItem):
		_createItemEntryByName(item_name)

func _createItemEntryByName(itemName):
	var entry = {"name": itemName, "quantity": 1}
	playerCollectedItems.push_front(entry)
	return entry

func remove_item_by_name(item_name):
	for item in playerCollectedItems:
		if (item.name == item_name):
			item.quantity -= 1

func print_collected_items():
	print("PRINTING ITEMS")
	for item in playerCollectedItems:
		print("**ITEM**")
		print(item.name)
		print(item.quantity)

func getItemsInInventory():
	return playerCollectedItems