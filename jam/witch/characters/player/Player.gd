extends KinematicBody2D

class_name Player

const MOVE_SPEED = 125

var move_dir = {
	'x': 0,
	'y': 0
}

enum Directions { UP, DOWN, LEFT, RIGHT }
var facing_dir

var money = 0 setget set_money,get_money
var potions_unlocked = 0

export(NodePath) var DIALOG_REF
var dialog_ref
var interacting_with

func _ready():
	dialog_ref = get_node(DIALOG_REF)

func _physics_process(delta):
	if dialog_ref.visible && is_instance_valid(interacting_with) && interacting_with.is_in_group("Dialog"):
		if Input.is_action_just_pressed("player_interact") && len(interacting_with.dialog_sequence) > interacting_with.current_phrase + 1:
			interacting_with.current_phrase += 1
			dialog_ref.text_box.set_text(interacting_with.dialog_sequence[interacting_with.current_phrase])
		elif Input.is_action_just_pressed("player_interact") && interacting_with.is_in_group("Dialog"):
			interacting_with.current_phrase = 0
			dialog_ref.visible = false
	if money >= 1000 && potions_unlocked >= 13:
		get_tree().change_scene("res://scenes/ThankYou.tscn")

func _on_DialogTrigger_area_entered(area):
	interacting_with = area.get_parent()
	if (interacting_with.get("item_name")):
		interacting_with.toggle_dialog(true)
	elif (interacting_with.get("dialog_sequence") && interacting_with.is_in_group("Dialog")):
		dialog_ref.text_box.set_text(interacting_with.dialog_sequence[0])
		dialog_ref.visible = true
	elif (interacting_with.is_in_group("Interactable")):
		interacting_with.interactable_area_entered()

func _on_DialogTrigger_area_exited(area):
	interacting_with = area.get_parent()
	if (interacting_with.get("item_name")):
		interacting_with.toggle_dialog(false)
	elif (interacting_with.get("dialog_sequence") && interacting_with.is_in_group("Dialog")):
		interacting_with.current_phrase = 0
		dialog_ref.visible = false
	elif (interacting_with.is_in_group("Interactable")):
		interacting_with.interactable_area_exited()

func set_money(amount):
	money = amount
	print("set_money ran - money: %d" % money)

func get_money():
	return money
