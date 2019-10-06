extends "res://utilities/State.gd"
const Updates = preload("Updates.gd") # Relative path
var Items = load("res://inventory/Items.gd")

onready var InventoryItemTemplate = preload("res://InventoryTest.tscn")
onready var invtest = preload("res://InventoryTest.tscn")

var inventory
var menu
var itemlist
var player

func enter():
	.enter()
	add_child(invtest.instance())
	# inventory = get_node("../../Inventory")
	# menu = get_node("../../../Canvas/Menu")
	# itemlist = get_node("../../../Canvas/Menu/ItemList")
	# player = get_node("../../../Player")

	# print("Menu")
	# recursive_show(menu, true)

	# for item in inventory.getItemsInInventory():
	# 	var menu_item = InventoryItemTemplate.instance()
	# 	var instance = Items.getInstanceOfItemByItemName(item.name)
	# 	itemlist.add_child(menu_item)
	# 	menu_item.set_name(item.name)
	# 	menu_item.set_image(instance.texture)
	# 	menu_item.set_count(item.quantity)
	# 	menu_item.set_ref(instance)
	# 	menu_item.set_player_ref(player)


	#var distance2Hero = enemy.get_global_pos().distance_to(hero.get_global_pos()); if(distance2Hero<100): enemy.throwBulletAt(hero);

func update():
	if Updates.check_menu():
		recursive_show(menu, false)
		emit_signal("change_state", "idle")

func recursive_show(node, b):
	for child in node.get_children():
		recursive_show(child, b)
	if node.get("visible"):
		node.visible = b
