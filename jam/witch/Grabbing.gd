extends "res://State.gd"
const Updates = preload("Updates.gd") # Relative path

var inventory

func enter():
	.enter()
	inventory = get_node("../../Inventory")

	print("Grabbing")
	var item_to_grab = getNearestItem()
	if(item_to_grab):
		inventory.add_item_by_name(item_to_grab.item_name)
		item_to_grab.free()
		print("got an item")


	#var distance2Hero = enemy.get_global_pos().distance_to(hero.get_global_pos()); if(distance2Hero<100): enemy.throwBulletAt(hero);

func update(delta):
	if Updates.check_grab():
		emit_signal("change_state", "grabbing")
	if Updates.check_walk():
		emit_signal("change_state", "walk")

func getNearestItem():
	var items = get_tree().get_nodes_in_group("Item")
	for item in items:
		var distanceToActor = item.position.distance_to(actor.position)

		if(distanceToActor<100):
			print(distanceToActor)
			return item;
		else:
			print("Nothing to grab :(")
	return