
var Items = load("res://inventory/Items.gd")

# Does not remove anything from inventory
# This should not be in charge of removing items from inventory
func getMoneyForItem(itemName):
	var items = Items.getNamedItemTypes()
	var item = items[itemName]
	return item.price