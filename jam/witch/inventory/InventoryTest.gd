extends Control

var item_list
var quantity_list
var inventory
var selected = [1000]

func _ready():
	inventory = get_node("../../Player/Inventory")
	item_list = get_node("ItemList")
	quantity_list = $QuantityList
#	item_list.add_item("Mushroom", load("res://items/Mushroom/Mushroom.png"))
	print("Inventory Test Ready")
	

func refresh_items():
	item_list.clear()
	quantity_list.clear()
	
	for item in inventory.playerCollectedItems:
		item_list.add_item(item.name, load("res://items/" + item.name + "/" + item.name + ".png"))
		quantity_list.add_item(str(item.quantity))
		

func _physics_process(delta):
	var new_selected = item_list.get_selected_items()
	if(len(new_selected) > 0):
		if (new_selected[0] != selected[0]):
			selected = new_selected
			print(item_list.get_item_text(selected[0]))
