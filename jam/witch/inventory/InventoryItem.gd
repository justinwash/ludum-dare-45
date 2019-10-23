extends Control

class_name InventoryItem

onready var Items = preload("res://inventory/Items.gd")

var inventory
var player_ref
var inventory_ui

var item_id
var item_image
var item_name
var item_count_label
var item_button

var item_inst

var item_count


func _ready():
	player_ref = get_tree().get_root().get_node("Main/Player")
	inventory = player_ref.get_node("Inventory")
	inventory_ui = get_tree().get_root().get_node("Main/Canvas/InventoryUI")
	
	item_image = get_node("HSplitContainer/LeftHBox/CenterContainer/ItemImage")
	item_name = get_node("HSplitContainer/LeftHBox/CenterContainer2/ItemName")
	item_count_label = get_node("HSplitContainer/RightHBox/CenterContainer3/ItemCount")
	item_button = get_node("HSplitContainer/RightHBox/CenterContainer4/Carry")

func _physics_process(delta):
	pass
	
func set_inventory_entry_properties(item_inst, count):
	self.item_inst = item_inst
	item_id = item_inst.id
	item_image.texture = item_inst.texture
	item_name.text = item_inst.item_name
	item_count = count
	item_count_label.text = str(item_count)
	item_image.hint_tooltip = item_inst.description

	item_button.text = "Carry"
	
	var nearestInteractable = getNearestInteractable()
	if nearestInteractable:
		if nearestInteractable.name == "Cauldron":
			item_button.text = "Mix"
			
func set_button_text(text):
	item_button.text = text

func _on_Carry_button_up():
	var item = inventory.get_item_by_name(item_name.text)
	if item.quantity > 0:
		var nearestInteractable = getNearestInteractable()
		if nearestInteractable:
			if nearestInteractable.name == "Cauldron":
				nearestInteractable.interact_with_item(item_inst)
				item_count = inventory.get_item_by_name(item.name).quantity
				item_count_label.text = str(item_count)
			elif nearestInteractable.name == "Market":
				nearestInteractable.interact_with_item(item_inst)
				item_count = inventory.get_item_by_name(item.name).quantity
				item_count_label.text = str(item_count)
				inventory_ui.money_label.text = "Money: $%d" % player_ref.money
		else:
			var carried = player_ref.get_node("CarriedItem")
			carried.set_current_item(item.name)
			carried.set_visibility(true)
			inventory_ui.visible = false
			
		
func getNearestInteractable():
	var interactables = get_tree().get_nodes_in_group("Interactable")
	var distances = []
	for interactable in interactables:
		var distanceToActor = interactable.position.distance_to(player_ref.position)
	
		if(distanceToActor < 50):
			distances.append({"interactable":interactable, "distance":distanceToActor})
	
	if distances.size() > 0:
		var minDistance = 1000
		var interactable
		for pair in distances:
			if pair.distance < minDistance:
				interactable = pair.interactable
				minDistance = pair.distance
		return interactable
		
	return null
