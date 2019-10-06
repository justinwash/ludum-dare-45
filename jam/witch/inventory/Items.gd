extends Node
const Mushroom = preload("res://items/Mushroom/Mushroom.gd")
const Leaf = preload("res://items/Leaf/Leaf.gd")
const Acorn = preload("res://items/Acorn/Acorn.gd")
const Elderberry = preload("res://items/Elderberry/Elderberry.gd")


var types = {
	"Mushroom": load("res://items/Mushroom/Mushroom.gd").new(),
	"Leaf": load("res://items/Leaf/Leaf.gd").new(),
	"Acorn": load("res://items/Acorn/Acorn.gd").new(),
	"Elderberry": load("res://items/Elderberry/Elderberry.gd").new()
}

static func getNamedItemTypes():
	return {
		"Mushroom": Mushroom,
		"Leaf": Leaf,
		"Acorn": Acorn,
		"Elderberry": Elderberry
	}

static func getItemTypes():
	return [Mushroom, Leaf, Acorn, Elderberry]

static func getInstanceOfItemByItemName(itemName):
	var items = getNamedItemTypes()
	var item = items[itemName]
	var instance = item.new()
	print(str(instance))
	return instance