extends Node

var ItemQuantityPair = preload("res://ItemQuantityPair.gd")
var Item = preload("res://Item.gd").new()
var items := []

func add_item(id, quantity):
    if quantity > 0:
        var iqp = get_item_quantity_pair(id)
        if iqp != null:
            iqp.quantity += quantity
        else:
            iqp = ItemQuantityPair.new()
            iqp.item = Item.get_item_from_id(0)
            iqp.quantity = quantity
            items.push_back(iqp)
    else:
        print("Cannot add a negative amount of item")

func remove_item(id, quantity):
    if quantity > 0:
        var iqp = get_item_quantity_pair(id)
        if iqp != null and iqp.quantity >= quantity:
            iqp.quantity -= quantity
        else:
            print("Not enough of item in inventory to remove " + quantity)
    else:
        print("Cannot remove a negative amount of item")

func get_item_quantity_pair(id):
	for iqp in items:
		print(iqp.item.id)
		if (iqp.item.id == id):
            return iqp
	return null