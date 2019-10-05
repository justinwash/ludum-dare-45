extends Control

var Inventory_Ref
var BroomCount_Ref

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory_Ref = get_node("Inventory")
	BroomCount_Ref = get_node("BroomCount")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_button_up():
	Inventory_Ref.add_item(0)