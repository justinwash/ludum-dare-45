extends Control

onready var Items = preload("res://inventory/Items.gd")

var item_list
var quantity_list

var money_label
var potion_label

var player
var inventory

var selected = [1000]

func _ready():
	player = get_node("../../Player")
	inventory = get_node("../../Player/Inventory")
	item_list = get_node("ItemList")
	quantity_list = $QuantityList
	money_label = get_node("MoneyPanel/MoneyLabel")
	potion_label = get_node("MoneyPanel/PotionLabel")
	print("Inventory Test Ready")


func refresh_items():
	item_list.clear()
	quantity_list.clear()

	for item in inventory.playerCollectedItems:
		var item_inst = Items.getInstanceOfItemByItemName(item.name)
		item_list.add_item(item_inst.item_name, item_inst.texture)
		quantity_list.add_item(str(item.quantity), load("res://tiles/blank_16x16.png"))

	money_label.text = "Money: " + str(player.get_money())
	potion_label.text = "Potions Unlocked: %s/13" % str(player.potions_unlocked)
	

func _physics_process(delta):
	var new_selected = item_list.get_selected_items()
	if(len(new_selected) > 0):
		if (new_selected[0] != selected[0]):
			selected = new_selected
			print(item_list.get_item_text(selected[0]))


func _on_ItemList_item_activated(index):
	var item = inventory.playerCollectedItems[index]
	if item.quantity > 0:
		var carried = player.get_node("CarriedItem")
		carried.set_current_item(item.name)
		carried.set_visibility(true)
		self.visible = false

