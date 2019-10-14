extends "res://utilities/FiniteStateMachine.gd"

class_name StateMachine

func _ready():
	states = {
		"idle": $Idle,
		"walk": $Walk,
		"grabbing": $Grabbing,
		"menu": $Menu,
		"attack": $Attack,
	}
