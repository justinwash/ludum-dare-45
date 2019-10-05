extends Node2D
const Leaf = preload("../items/Leaf/Leaf.gd")
const Mushroom = preload("../items/Mushroom/Mushroom.gd")
const MAX_ITEMS_PLACED = 50

func _ready():
	for i in range(MAX_ITEMS_PLACED):
		var posVector = getRandomVector2(400, 400)
		print(posVector)
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
	if (index == 0):
		print("Making a leaf")
	else:
		print("Making a shroom")
	return item.new()

func addItemToItems(item): 
	var Items = get_node("Items")
	Items.add_child_below_node(Items, item)
	print(Items.get_child_count())