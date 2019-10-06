extends Node2D

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
	if carried.current_item:
		if not items.has(carried.current_item):
			items.append(carried.current_item)
			inventory.remove_item_by_name(carried.current_item.item_name)
			
			var image = TextureRect.new()
			image.set_texture(carried.current_item.texture)
			GridContainer.add_child(image)
			
			carried.current_item = null
			carried.visible = false
			
func interactable_area_entered():
	for item in items:
		var image = TextureRect.new()
		image.set_texture(item.texture)
		GridContainer.add_child(image)
	ColorRect.visible = true
	
func interactable_area_exited():
	for child in GridContainer.get_children():
		child.free()
	ColorRect.visible = false

