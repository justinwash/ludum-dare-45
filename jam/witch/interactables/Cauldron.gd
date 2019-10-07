extends Node2D

onready var Items = preload("res://inventory/Items.gd")

var items = []

var player
var inventory


var GridContainer
var ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	inventory = player.get_node("Inventory")
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

func interactable_area_entered():
	refresh_item_display()
	ColorRect.visible = true

func interactable_area_exited():
	for child in GridContainer.get_children():
		child.free()
	ColorRect.visible = false
	
func refresh_item_display():
	for child in GridContainer.get_children():
		child.free()
	for item in items:
		var image = TextureRect.new()
		image.set_texture(item.texture)
		GridContainer.add_child(image)
		
func try_create_recipe():
	var item_ids = []
	for item in items:
		item_ids.append(item.id)
	
	var potion
	if item_ids.has(1) and item_ids.has(3):
		potion = Items.getInstanceOfItemByItemName("Potion of Minor Stomach Aches")
		remove_single_item_by_id(1)
		remove_single_item_by_id(3)
		items.append(potion)
		refresh_item_display()
		
func remove_single_item_by_id(item_id):
	var i = 0
	for item in items:
		if item.id == item_id:
			items.remove(i)
		i += 1
	print(str(items))