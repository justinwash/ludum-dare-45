extends "res://State.gd"
const Updates = preload("Updates.gd") # Relative path

func enter():
	.enter()

	print("Grabbing")
	var nearestShroom = getNearestGrabbableShroom()
	if(nearestShroom):
		print("GOT A SHROOM")
	
	#var distance2Hero = enemy.get_global_pos().distance_to(hero.get_global_pos()); if(distance2Hero<100): enemy.throwBulletAt(hero);

func update(delta):
	if Updates.check_grab():
		emit_signal("change_state", "grabbing")
	if Updates.check_walk(): 
		emit_signal("change_state", "walk")
		
func getNearestGrabbableShroom():
	var shroom = actor.get_parent().get_node("Shroom")
	var distanceToActor = (shroom as Node2D).position.distance_to((actor as KinematicBody2D).position)
	
	if(distanceToActor<100):
		print(distanceToActor)
		return shroom;
	else:
		print("Nothing to grab :(")
		
	return