
var Items = load("res://inventory/Items.gd")

# Does not remove anything from inventory
# This should not be in charge of removing items from inventory
func sellItemByName(itemName):
	var items = Items.getNamedItemTypes()