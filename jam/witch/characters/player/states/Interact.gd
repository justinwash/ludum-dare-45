extends "res://utilities/State.gd"
const Updates = preload("Updates.gd") # Relative path

var inventory
var player

func enter():
	.enter()
	inventory = get_node("../../Inventory")
	player = get_node("../../../Player")

	print("Interacting")
	var item_to_grab = getNearestItem()
	if(item_to_grab):
		inventory.add_item_by_name(item_to_grab.item_name)
		item_to_grab.free()
		print("got an item")
	else:
		print("Nothing to take")
		var object_to_interact = getNearestInteractable()
		if object_to_interact:
			print("interacting with " + str(object_to_interact.name))
			object_to_interact.interact()
	
	var carriedItem = player.get_node("CarriedItem").get("current_item")
	if (carriedItem && carriedItem.get("id")):
		if (carriedItem.id > 49 && carriedItem.id < 70):
			consumePotion(carriedItem)


	#var distance2Hero = enemy.get_global_pos().distance_to(hero.get_global_pos()); if(distance2Hero<100): enemy.throwBulletAt(hero);
func consumePotion(potion):
	#run potion code
	potion.consume()
	
	#remove potion from inventory
	inventory.remove_item_by_name(potion.item_name)

	#remove potion from carried
	player.get_node("CarriedItem").set_current_item(null)
	player.get_node("CarriedItem").set_visibility(false)

func update():
	if Updates.check_grab():
		emit_signal("change_state", "grabbing")
	if Updates.check_walk():
		emit_signal("change_state", "walk")
	else:
		emit_signal("change_state", "idle")

func getNearestItem():
	var items = get_tree().get_nodes_in_group("Item")
	for item in items:
		var distanceToActor = item.position.distance_to(actor.position)

		if(distanceToActor < 50):
			print(distanceToActor)
			return item;
	return null

func getNearestInteractable():
	var items = get_tree().get_nodes_in_group("Interactable")
	for item in items:
		var distanceToActor = item.position.distance_to(actor.position)

		if(distanceToActor < 50):
			print(distanceToActor)
			return item;
	return null