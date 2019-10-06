# extends Node

# var PlayerRef

# var ItemRef
# var ItemName
# var ItemImage
# var ItemCount
# var count

# func _ready():
# 	ItemName = get_node("HBoxContainer/ItemName")
# 	ItemImage = get_node("HBoxContainer/ItemImage")
# 	ItemCount = get_node("HBoxContainer/ItemCount")

# func set_name(name):
# 	ItemName.text = name

# func set_image(image):
# 	ItemImage.set_texture(image)

# func set_count(count):
# 	ItemCount.text = str(count)
# 	self.count = count

# func set_ref(node):
# 	ItemRef = node

# func set_player_ref(player):
# 	PlayerRef = player

extends Control

var item_list
var inventory
var selected = [1000]
var player_ref


func _ready():
	player_ref = get_node("../../Player")
	print(player_ref)
	inventory = load("res://inventory/Inventory.gd")
	item_list = get_node("ItemList")
	item_list.add_item("")
	item_list.add_item("Mushroom", load("res://items/Mushroom/Mushroom.png"))
	item_list.add_item("Leaf", load("res://items/Leaf/Leaf.png"))

func _physics_process(delta):
	var new_selected = item_list.get_selected_items()
	if(len(new_selected) > 0):
		if (new_selected[0] != selected[0]):
			selected = new_selected
			var carried = player_ref.get_node("CarriedItem")
			carried.set_texture(item_list.get_item_icon(selected[0]))
			carried.visible = true
			carried.current_item = inventory.get_item_by_name(item_list.get_item_text(selected[0]))
			print(item_list.get_item_text(selected[0]))
			print(carried)
