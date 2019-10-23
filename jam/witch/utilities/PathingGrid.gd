tool
extends Node2D

export var grid_world_size : Vector2 setget set_grid_world_size
export var node_radius = 10.0 setget set_node_radius

export var query_shape : Shape2D

export var reset = false setget set_reset

var grid

var node_diameter
var grid_size_x : int
var grid_size_y : int

var refresh_grid = false
var refresh_nodes = false

onready var _Debugging = DebuggingAgain
var _debugging

export var walkable_color : Color
export var obstacle_color : Color

func _init():
	pass

func _ready():
	_debugging = get_node("Debugging")

	calculate_members()
	
	refresh_grid = true
	refresh_nodes = true

func calculate_members():
	node_diameter = node_radius * 2
	grid_size_x = int(round(grid_world_size.x/node_diameter))
	grid_size_y = int(round(grid_world_size.y/node_diameter))
	print("grid size was (%d,%d)" % [grid_size_x, grid_size_y])

func display_nodes():
	if not _debugging.circles.empty():
		_debugging.circles.clear()
	
	if Engine.editor_hint:
		for x in range(grid.size()):
			for y in range(grid[x].size()):
				var node = grid[x][y]
				var color = walkable_color if node.walkable else obstacle_color
				var circle = _Debugging.Circle.new(node.position, 10.0, color)
				_debugging.add_circle(circle)

func _process(delta):
	if not _debugging:
		_debugging = get_node("Debugging")
		
func _physics_process(delta):
	if refresh_grid:
		print("refreshing grid")
		create_grid()
		refresh_grid = false
	if refresh_nodes:
		print("refreshing node display")
		display_nodes()
		refresh_nodes = false

func set_grid_world_size(vec2):
	grid_world_size = vec2
	calculate_members()
	clear_grid()
	refresh_grid = true
	refresh_nodes = true

func clear_grid():
	if grid:
		grid.clear()
	else:
		grid = []

func set_node_radius(radius):
	node_radius = radius
	calculate_members()
	clear_grid()
	refresh_grid = true
	refresh_nodes = true

func create_grid():
	grid = []
	grid.resize(grid_size_x)
	for x in range(grid_size_x):
		grid[x] = []
		grid[x].resize(grid_size_y)

	var world_top_left = self.position # - Vector2(1,0)*grid_world_size.x - Vector2(0,1)*grid_world_size.y
	var query = Physics2DShapeQueryParameters.new()
	query.set_shape(query_shape)

	for x in range(grid_size_x):
		for y in range(grid_size_y):
			var world_point = world_top_left + Vector2(1,0)*(x*node_diameter + node_radius) + Vector2(0,1)*(y*node_diameter+node_radius)
			query.set_transform(Transform2D(0.0, world_point))
			var world_2d = get_world_2d()
			var walkable = world_2d.get_direct_space_state().intersect_shape(query).empty()
			grid[x][y] = PathNode.new(walkable, world_point, x, y)

func node_from_world_point(pos):
	if grid && grid.size() > 0:
		var percent_x = pos.x/grid_world_size.x
		var percent_y = pos.y/grid_world_size.y
		percent_x = clamp(percent_x, 0, 1)
		percent_y = clamp(percent_y, 0, 1)
	
		var x = int(round((grid_size_x-1)*percent_x))
		var y = int(round((grid_size_y-1)*percent_y))
	
		return grid[x][y]

func get_neighbors(node):
	var neighbors = []

	for x in range(-1,2):
		for y in range(-1,2):
			if x == 0 && y == 0:
				pass
			else:
				var check_x = node.grid_x + x
				var check_y = node.grid_y + y

				if check_x >= 0 && check_x < grid_size_x && check_y >= 0 && check_y < grid_size_y:
					neighbors.append(grid[check_x][check_y])
	
	return neighbors

func set_reset(b):
	if b:
		grid.clear()
		calculate_members()
		create_grid()
		display_nodes()
		reset = false

class PathNode:
	var grid_x : int
	var grid_y : int

	var parent

	var walkable : bool
	var aux_walkable : bool
	var position : Vector2

	var g_cost : int
	var h_cost : int
	var f_cost : int setget ,get_f_cost

	func _init(_walkable, _world_pos, _grid_x, _grid_y):
		walkable = _walkable
		position = _world_pos
		grid_x = _grid_x
		grid_y = _grid_y

	func get_f_cost():
		return h_cost + g_cost

	func get_h_cost():
		return h_cost

	func get_g_cost():
		return g_cost

	func set_h_cost(h):
		h_cost = h

	func set_g_cost(g):
		g_cost = g


	

