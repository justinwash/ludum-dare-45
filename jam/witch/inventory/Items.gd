extends Node

const Acorn = preload("res://items/Acorn/Acorn.gd")
const Elderberry = preload("res://items/Elderberry/Elderberry.gd")
const Leaf = preload("res://items/Leaf/Leaf.gd")
const Mushroom = preload("res://items/Mushroom/Mushroom.gd")

const PotionOfMinorStomachAches = preload("res://items/PotionOfMinorStomachAches/PotionOfMinorStomachAches.gd")

var types = {
	"Acorn": load("res://items/Acorn/Acorn.gd").new(),
	"Elderberry": load("res://items/Elderberry/Elderberry.gd").new(),
	"Leaf": load("res://items/Leaf/Leaf.gd").new(),
	"Mushroom": load("res://items/Mushroom/Mushroom.gd").new(),
	
	"PotionOfMinorStomachAches": load("res://items/PotionOfMinorStomachAches/PotionOfMinorStomachAches.gd").new()
}

static func getNamedItemTypes():
	return {
		"Acorn": Acorn,
		"Elderberry": Elderberry,
		"Leaf": Leaf,
		"Mushroom": Mushroom,
		
		"Potion of Minor Stomach Aches": PotionOfMinorStomachAches
	}

static func getItemTypes():
	return [Mushroom, Leaf, Acorn, Elderberry]

static func getInstanceOfItemByItemName(itemName):
	var items = getNamedItemTypes()
	var item = items[itemName]
	var instance = item.new()
	print(str(instance))
	return instance