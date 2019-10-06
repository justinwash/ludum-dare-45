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

# func _on_Carry_button_up():
# 	if self.count > 0:
# 		var carried = PlayerRef.get_node("CarriedItem")
# 		carried.set_texture(ItemImage.texture)
# 		carried.visible = true
# 		carried.current_item = ItemRef

extends Control

var item_list
var inventory
var selected = [1000]

func _ready():
	inventory = load("res://inventory/Inventory.gd")
	item_list = get_node("ItemList")
	item_list.add_item("Mushroom", load("res://items/Mushroom/Mushroom.png"))
	item_list.add_item("Leaf", load("res://items/Leaf/Leaf.png"))

func _physics_process(delta):
	var new_selected = item_list.get_selected_items()
	if(len(new_selected) > 0):
		if (new_selected[0] != selected[0]):
			selected = new_selected
			print(item_list.get_item_text(selected[0]))
