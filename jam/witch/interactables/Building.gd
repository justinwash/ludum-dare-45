extends Node2D

class_name Building

export var scene : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	get_tree().change_scene(scene)

