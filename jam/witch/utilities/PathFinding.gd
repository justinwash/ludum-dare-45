tool
extends Node

export var pathing_grid_path : NodePath
var pathing_grid
var canvas

onready var _Debugging = DebuggingAgain
var _debugging

export var debugging = false
export var debug_start_path : NodePath
var debug_start
export var debug_end_path : NodePath
var debug_end

export var debug_current_node_color = Color("#ff0000")

var debug_path = []

func _ready():
	pathing_grid = get_node(pathing_grid_path)
	debug_start = get_node(debug_start_path)
	debug_end = get_node(debug_end_path)
	if pathing_grid && debug_start && debug_end:
		print("actually got the fucking members")
	canvas = get_tree().get_root().get_node("Main/Canvas")
	_debugging = get_node("Debugging")

func _physics_process(delta):
	if not _debugging:
		_debugging = get_node("Debugging")
	#if not pathing_grid:
		#pathing_grid = get_node("PathingGrid")

	if Engine.editor_hint:
		if debugging:
			if not debug_path || debug_path.empty():
				debug_path = find_path(debug_start.position, debug_end.position)
				if not debug_path.empty():
					print("found path")
					for node in debug_path:
						var circle = _Debugging.Circle.new(node.position, 10.0, Color(0,255,0))
						_debugging.add_circle(circle)
				else:
					print("failed to find path")
					debugging = false


func find_path(start_pos, end_pos):
	var start = pathing_grid.node_from_world_point(start_pos)
	print("start node found at (%d,%d)" % [start.position.x, start.position.y])
	print("start node was %f from start_pos" % start.position.distance_to(start_pos))
	var end = pathing_grid.node_from_world_point(end_pos)
	print("end node found at (%d,%d)" % [end.position.x, end.position.y])
	print("end node was %f from end_pos" % end.position.distance_to(end_pos))

	var open = []
	var closed = []

	open.append(start)

	while open.size() > 0:
		var current_node = open[0]

		if Engine.editor_hint:
			_debugging.circles = []
			for node in open:
				var circle = _Debugging.Circle.new(node.position, 5.0, debug_current_node_color)
				_debugging.add_circle(circle)

		for i in range(1, open.size()):
			if (open[i].f_cost < current_node.f_cost) || (open[i].f_cost == current_node.f_cost && open[i].h_cost < current_node.h_cost):
				current_node = open[i]

		open.erase(current_node)
		closed.append(current_node)

		if current_node == end:
			return get_node_path(start, end)

		var neighbors = pathing_grid.get_neighbors(current_node)
		for neighbor in neighbors:
			if not neighbor.walkable || closed.has(neighbor):
				continue
			var new_move_cost_to_neighbor = current_node.g_cost + get_distance(current_node, neighbor)
			if (new_move_cost_to_neighbor < neighbor.g_cost || not open.has(neighbor)):
				neighbor.g_cost = new_move_cost_to_neighbor
				neighbor.h_cost = get_distance(neighbor, end)
				neighbor.parent = current_node

				if not open.has(neighbor):
					open.append(neighbor)
	return []

func get_distance(node_a, node_b):
	var dst_x = abs(node_a.grid_x - node_b.grid_x)
	var dst_y = abs(node_a.grid_y - node_b.grid_y)

	if (dst_x > dst_y):
		return 14*dst_y + 10*(dst_x - dst_y)
	else:
		return 14*dst_x + 10*(dst_y - dst_x)

func get_node_path(start_node, end_node):
	var path = []
	var current_node = end_node

	while current_node != start_node:
		path.append(current_node)
		current_node = current_node.parent

	path.invert()
	return path

func highlight_path(path):
	# var line = Line2D.new()
	# line.z_index = 1
	# if path && path.size() > 0:
	# 	for i in range(path.size()):
	# 		line.add_point(path[i].position)
	# 	add_child(line)
	pass