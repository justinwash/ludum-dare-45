extends "res://State.gd"
const Updates = preload("Updates.gd") # Relative path

func enter():
	.enter()

	print("Grabbing")

func update(delta):
	if Updates.check_grab():
		emit_signal("change_state", "grabbing")
	if Updates.check_walk(): 
		emit_signal("change_state", "walk")