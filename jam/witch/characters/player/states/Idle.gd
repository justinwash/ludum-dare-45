extends "res://utilities/State.gd"

class_name Idle

const Updates = preload("Updates.gd") # Relative path

func enter():
	.enter()

	print("idle")

func update():
	if Updates.check_walk():
		emit_signal("change_state", "walk")
	if Updates.check_grab():
		emit_signal("change_state", "grabbing")
	if Updates.check_menu():
		emit_signal("change_state", "menu")
	if Updates.check_attack():
		emit_signal("change_state", "attack")
