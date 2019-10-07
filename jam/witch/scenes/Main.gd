extends Node2D
const Leaf = preload("../items/Leaf/Leaf.tscn")
const Mushroom = preload("../items/Mushroom/Mushroom.tscn")
const Acorn = preload("../items/Acorn/Acorn.tscn")
const Elderberry = preload("../items/Elderberry/Elderberry.tscn")
const Feather = preload("../items/Feather/Feather.tscn")
const MAX_ITEMS_PLACED = 100
const X_MAX = 1000
const Y_MAX = 1000
const ITEM_GROUP = "Item"
const ITEMS_NODE = "Items"

func _ready():
	var lastPositionPlaced = Vector2(50, 50);

	for i in range(MAX_ITEMS_PLACED):
		var posVector
		var newItem = getRandomItem()

		if(shouldBiasPlacement()):
			posVector = getBiasedVector(lastPositionPlaced)
		else:
			posVector = getRandomVector2(X_MAX, Y_MAX)

		lastPositionPlaced = posVector
		(newItem as Node2D).position = posVector
		addItemToItems(newItem)

func getRandomVector2(xMax, yMax) -> Vector2:
	var xPos = randi()%xMax+1
	var yPos = randi()%yMax+1
	return Vector2(xPos, yPos)

func shouldBiasPlacement():
	return _fiftyfifty()

func _fiftyfifty():
	return bool((randi()%2+1)-1)

func getBiasedVector(vector):
	var xChange = (randi()%50+1)-1
	var yChange = (randi()%50+1)-1
	var posOrNeg = _fiftyfifty()
	var xPos
	var yPos

	if (posOrNeg):
		xPos = (vector as Vector2).x + xChange
		yPos = (vector as Vector2).y + yChange
	else:
		xPos = (vector as Vector2).x - xChange
		yPos = (vector as Vector2).y - yChange

	return Vector2(xPos, yPos)

func getRandomItem():
	var items = [Leaf, Mushroom, Acorn, Elderberry, Feather]
	var index = (randi()%items.size()+1)-1
	var item = items[index]
	return item.instance()

func addItemToItems(item):
	var Items = get_node(ITEMS_NODE)
	Items.add_child(item)
	(item as Node2D).add_to_group(ITEM_GROUP)
#	Items.add_child_below_node(Items, item)