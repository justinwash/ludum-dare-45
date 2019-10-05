extends Control
var Broom_Ref = preload("res://items/Mushroom.gd")

var Inventory_Reference
var BroomCount_Ref

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory_Reference = get_node("Inventory")
	BroomCount_Ref = get_node("BroomCount")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_button_up():
	Inventory_Reference.add_item(0, 1)
	var iqp = Inventory_Reference.get_item_quantity_pair(0)
	BroomCount_Ref.text = "Broom Count: " + iqp.quantity
