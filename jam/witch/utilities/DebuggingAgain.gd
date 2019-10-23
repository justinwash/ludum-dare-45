tool
extends Node2D

class_name DebuggingAgain

var circles = [] setget set_circles

export var override_circle_size = false setget set_circle_size_override
export var circle_size = 0.0 setget set_circle_size

func _draw():
	if Engine.editor_hint:
		if circles:
			for circle in circles:
				var r = circle_size if override_circle_size else circle.radius
				draw_circle(circle.center, r, circle.color)

func _ready():
	pass # Replace with function body.

func _process(delta):
	# update()
	pass

func add_circle(circle):
	circles.append(circle)
	update()

func set_circles(new_circles):
	circles = new_circles
	update()

func set_circle_size_override(b):
	override_circle_size = b
	update()

func set_circle_size(r):
	circle_size = r
	update()

class Circle:
	var center : Vector2
	var radius : float
	var color : Color

	func _init(_center, _radius, _color):
		center = _center
		radius = _radius
		color = _color