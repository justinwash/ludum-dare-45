extends Node2D
const Leaf = preload("../items/Leaf/Leaf.tscn")
const Mushroom = preload("../items/Mushroom/Mushroom.tscn")
const MAX_ITEMS_PLACED = 50
const X_MAX = 400
const Y_MAX = 400
const ITEM_GROUP = "Item"
const ITEMS_NODE = "Items"

func _ready():
	for i in range(MAX_ITEMS_PLACED):
		var posVector = getRandomVector2(X_MAX, Y_MAX)
		var newItem = getRandomItem()
		(newItem as Node2D).position = posVector
		addItemToItems(newItem)
		
func getRandomVector2(xMax, yMax) -> Vector2:
	var xPos = randi()%xMax+1
	var yPos = randi()%yMax+1
	return Vector2(xPos, yPos)

func getRandomItem():
	var items = [Leaf, Mushroom]
	var index = (randi()%items.size()+1)-1
	var item = items[index]
	return item.instance()

func addItemToItems(item): 
	var Items = get_node(ITEMS_NODE)
	Items.add_child(item)
	(item as Node2D).add_to_group(ITEM_GROUP)
#	Items.add_child_below_node(Items, item)