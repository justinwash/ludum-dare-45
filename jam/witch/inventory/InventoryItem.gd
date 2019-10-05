extends Node

var PlayerRef

var ItemRef
var ItemName
var ItemImage
var ItemCount

func _ready():
	ItemName = get_node("HBoxContainer/ItemName")
	ItemImage = get_node("HBoxContainer/ItemImage")
	ItemCount = get_node("HBoxContainer/ItemCount")

func set_name(name):
	ItemName.text = name

func set_image(image):
	ItemImage.set_texture(image)

func set_count(count):
	ItemCount.text = str(count)

func set_ref(node):
	ItemRef = node
	
func set_player_ref(player):
	PlayerRef = player

func _on_Carry_button_up():
	if ItemRef.quantity > 0:
		var carried = PlayerRef.get_node("CarriedItem")
		carried.set_texture(ItemImage.texture)
		carried.visible = true
		carried.current_item = ItemRef
