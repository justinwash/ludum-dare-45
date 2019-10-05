extends "res://utilities/FiniteStateMachine.gd"

func _ready():
	states = {
		"idle": $Idle,
		"walk": $Walk,
		"grabbing": $Grabbing
	}
