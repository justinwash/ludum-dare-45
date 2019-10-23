extends Node2D

class_name Cauldron

onready var _Items = Items.new()

var items = []
var unlocks = [false, false, false, false, false, false, false, false, false, false, false, false, false]

var player
var inventory
var inventory_ui

var GridContainer
var ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Main/Player")
	inventory = player.get_node("Inventory")
	inventory_ui = get_tree().get_root().get_node("Main/Canvas/InventoryUI")
	GridContainer = get_node("ColorRect/GridContainer")
	ColorRect = get_node("ColorRect")

func interact():
	var carried = player.get_node("CarriedItem")
	if carried.get("current_item"):
		if not items.has(carried.current_item):
			items.append(carried.current_item)
			inventory.remove_item_by_name(carried.current_item.item_name)

			refresh_item_display()

			carried.set_current_item(null)
			carried.set_visibility(false)

			try_create_recipe()
	else:
		if items.size() > 0:
			var removed_item = items.back()
			items.remove(items.size()-1)
			inventory.add_item_by_name(removed_item.item_name)
			refresh_item_display()
			inventory_ui.refresh_items()
			
func interact_with_item(item):
		if not items.has(item):
			items.append(item)
			inventory.remove_item_by_name(item.item_name)

			refresh_item_display()
			try_create_recipe()

func interactable_area_entered():
	refresh_item_display()
	ColorRect.visible = true
	
	inventory_ui.set_all_button_text("Mix")

func interactable_area_exited():
	for child in GridContainer.get_children():
		child.free()
	ColorRect.visible = false
	
	inventory_ui.set_all_button_text("Carry")

func refresh_item_display():
	for child in GridContainer.get_children():
		child.free()
	for item in items:
		var image = TextureRect.new()
		image.set_texture(item.texture)
		GridContainer.add_child(image)

func try_create_recipe():
	var item_ids = get_item_ids()

	var potion
	if has_ingredients([1, 3]):
		potion = _Items.getInstanceOfItemByItemName("Potion of Minor Stomach Aches") # 50
		unlocks[0] = true
		remove_ingredients([1,3])
	elif has_ingredients([0, 2]):
		potion = _Items.getInstanceOfItemByItemName("Crunchy Nature Potion") # 51
		unlocks[1] = true
		remove_ingredients([0, 2])
	elif has_ingredients([50, 51]):
		potion = _Items.getInstanceOfItemByItemName("Tasty Health Potion") # 52
		unlocks[2] = true
		remove_ingredients([50, 51])
	elif has_ingredients([0, 3, 4]):
		potion = _Items.getInstanceOfItemByItemName("Greater Potion of Minor Narcolepsy") # 53
		unlocks[3] = true
		remove_ingredients([0, 3, 4])
	elif has_ingredients([2, 3, 4]):
		potion = _Items.getInstanceOfItemByItemName("Weak Potion of Greater Energy") # 54
		unlocks[4] = true
		remove_ingredients([2, 3, 4])
	elif has_ingredients([3, 4, 52]):
		potion = _Items.getInstanceOfItemByItemName("Potion of Advanced Revelry") # 55
		unlocks[5] = true
		remove_ingredients([3, 4, 52])
	elif has_ingredients([1, 4, 50]):
		potion = _Items.getInstanceOfItemByItemName("Scaly Potion of Enhanced Nausea") # 56
		unlocks[6] = true
		remove_ingredients([1, 4, 50])
	elif has_ingredients([52, 55]):
		potion = _Items.getInstanceOfItemByItemName("Potion of Toadspeak") # 57
		unlocks[7] = true
		remove_ingredients([52, 55])
	elif has_ingredients([50, 56, 57]):
		potion = _Items.getInstanceOfItemByItemName("Potion of Delusionary Toadform") # 58
		unlocks[8] = true
		remove_ingredients([50, 56, 57])
	elif has_ingredients([54, 56, 58]):
		potion = _Items.getInstanceOfItemByItemName("Potion of Lifelong Anxiety") # 59
		unlocks[9] = true
		remove_ingredients([54, 56, 58])
	elif has_ingredients([53, 59]):
		potion = _Items.getInstanceOfItemByItemName("Nightmare Fuel Concoction") # 60
		unlocks[10] = true
		remove_ingredients([53, 59])
	elif has_ingredients([54, 55]):
		potion = _Items.getInstanceOfItemByItemName("Potion of Neversleep") # 61
		unlocks[11] = true
		remove_ingredients([54, 55])
	elif has_ingredients([60, 61]):
		potion = _Items.getInstanceOfItemByItemName("Psychotic Episode in a Bottle") # 62
		unlocks[12] = true
		remove_ingredients([60, 61])

	if potion:
		items.append(potion)
		refresh_item_display()
		player.potions_unlocked = count_unlocks()

func count_unlocks():
	var count = 0
	for unlock in unlocks:
		if unlock:
			count += 1
	return count

func get_item_ids():
	var item_ids = []
	for item in items:
		item_ids.append(item.id)
	return item_ids

func has_ingredients(ingredient_ids):
	var item_ids = get_item_ids()
	for ingredient_id in ingredient_ids:
		if not item_ids.has(ingredient_id):
			return false
	return true

func remove_single_item_by_id(item_id):
	var i = 0
	for item in items:
		if item.id == item_id:
			items.remove(i)
		i += 1
	print(str(items))

func remove_ingredients(ingredient_ids):
	for ingredient_id in ingredient_ids:
		remove_single_item_by_id(ingredient_id)