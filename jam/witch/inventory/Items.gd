extends Node

const Acorn = preload("res://items/Acorn/Acorn.gd")
const Elderberry = preload("res://items/Elderberry/Elderberry.gd")
const Leaf = preload("res://items/Leaf/Leaf.gd")
const Mushroom = preload("res://items/Mushroom/Mushroom.gd")
const Feather = preload("res://items/Feather/Feather.gd")

const PotionOfMinorStomachAches = preload("res://items/PotionOfMinorStomachAches/PotionOfMinorStomachAches.gd")
const CrunchyNaturePotion = preload("res://items/CrunchyNaturePotion/CrunchyNaturePotion.gd")
const TastyHealthPotion = preload("res://items/TastyHealthPotion/TastyHealthPotion.gd")


var types = {
	"Acorn": load("res://items/Acorn/Acorn.gd").new(),
	"Elderberry": load("res://items/Elderberry/Elderberry.gd").new(),
	"Leaf": load("res://items/Leaf/Leaf.gd").new(),
	"Mushroom": load("res://items/Mushroom/Mushroom.gd").new(),
	"Feather": Feather.new(),

	"PotionOfMinorStomachAches": load("res://items/PotionOfMinorStomachAches/PotionOfMinorStomachAches.gd").new(),
	"CrunchyNaturePotion": load("res://items/CrunchyNaturePotion/CrunchyNaturePotion.gd").new(),
	"TastyHealthPotion": load("res://items/TastyHealthPotion/TastyHealthPotion.gd").new(),
}

static func getNamedItemTypes():
	return {
		"Acorn": Acorn,
		"Elderberry": Elderberry,
		"Leaf": Leaf,
		"Mushroom": Mushroom,
		"Feather": Feather,

		"Potion of Minor Stomach Aches": PotionOfMinorStomachAches,
		"Crunchy Nature Potion": CrunchyNaturePotion,
		"Tasty Health Potion": TastyHealthPotion,
	}

static func getItemTypes():
	return [Acorn, Elderberry, Leaf, Mushroom, Feather,
		PotionOfMinorStomachAches, CrunchyNaturePotion, TastyHealthPotion]

static func getInstanceOfItemByItemName(itemName):
	var items = getNamedItemTypes()
	var item = items[itemName]
	var instance = item.new()
	print(str(instance))
	return instance