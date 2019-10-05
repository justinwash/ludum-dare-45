extends Node

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

