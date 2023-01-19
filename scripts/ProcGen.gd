extends Node2D

var grid:Array = []
var visited:Array = []
var cell_order:Array = []
var grid_width:int
var grid_height:int

enum {GROUND, MONSTER, WALL, CHEST}

func procedural_generation(g_width, g_height):
	var start_cellx:int
	var start_celly:int
	var start_cell:Array
	
	grid_height = g_height
	grid_width = g_width
	start_cellx = randi() % grid_width
	start_celly = randi() % grid_height
	start_cell = [start_cellx, start_celly]
	generate_grid()
	generate_maze(start_cell, true)
	return grid

func generate_grid():
	for x in range(grid_width):
		grid.append([])
		for y in range(grid_height):
			grid[x].append([])
			grid[x][y] = WALL

func generate_maze(cell, flag):
	var x:int
	var y:int
	var valid_neighbors:Array
	var rand_cell:Array
	var is_visited:int
	var last_cell:Array
	
	is_visited = visited.find(cell)
	if (is_visited == -1):
		visited.append(cell)
	if (cell_order.find(cell) == -1):
		cell_order.append(cell)
	x = cell[0]
	y = cell[1]
	grid[x][y] = GROUND
	valid_neighbors = get_valid_neighbors(cell)
	if (!valid_neighbors.empty()):
		flag = true
		rand_cell = valid_neighbors[randi() % valid_neighbors.size()]
		generate_maze(rand_cell, flag)
	elif (!cell_order.empty()):
		if (flag):
			grid[x][y] = MONSTER
			flag = false
		cell_order.remove(cell_order.size()-1)
		if (cell_order.empty()):
			grid[x][y] = MONSTER
			return
		last_cell = cell_order[-1]
		generate_maze(last_cell, flag)
	else:
		return

func get_valid_neighbors(cell):
	var x:int = cell[0]
	var y:int = cell[1]
	var valid_neighbors:Array = []
	var is_visited:int
	var north_valid:int
	var east_valid:int
	var west_valid:int
	var south_valid:int
	
	### TEST IF NORTH IS VALID ###
	# test if north is in the grid and not in visited neighbors
	is_visited = visited.find([x, y-1])
	if (y - 1 >= 0 && is_visited == -1):
		# test if north has visited neighbors, valid = -1 if no visited neighbors
		north_valid = visited.find([x, y-2])
		east_valid = visited.find([x+1, y-1])
		west_valid = visited.find([x-1, y-1])
		if (east_valid == -1 && north_valid == -1 && west_valid == -1):
			valid_neighbors.append([x, y-1])
	
	### TEST IF EAST IS VALID ###
	# test if east is in the grid and not in visited neighbors
	is_visited = visited.find([x+1, y])
	if (x + 1 < grid_width && is_visited == -1):
		# test if east has visited neighbors, valid = -1 if no visited neighbors
		north_valid = visited.find([x+1, y-1])
		east_valid = visited.find([x+2, y])
		south_valid = visited.find([x+1, y+1])
		if (east_valid == -1 && north_valid == -1 && south_valid == -1):
			valid_neighbors.append([x+1, y])
	
	### TEST IF WEST IS VALID ###
	# test if west is in the grid and not in visited neighbors
	is_visited = visited.find([x-1, y])
	if (x - 1 >= 0 && is_visited == -1):
		# test if west has visited neighbors, valid = -1 if no visited neighbors
		north_valid = visited.find([x-1, y-1])
		west_valid = visited.find([x-2, y])
		south_valid = visited.find([x-1, y+1])
		if (south_valid == -1 && north_valid == -1 && west_valid == -1):
			valid_neighbors.append([x-1, y])
	
	### TEST IF SOUTH IS VALID ###
	# test if south is in the grid and not in visited neighbors
	is_visited = visited.find([x, y+1])
	if (y + 1 < grid_height && is_visited == -1):
		# test if south has visited neighbors, valid = -1 if no visited neighbors
		west_valid = visited.find([x-1, y+1])
		east_valid = visited.find([x+1, y+1])
		south_valid = visited.find([x, y+2])
		if (east_valid == -1 && west_valid == -1 && south_valid == -1):
			valid_neighbors.append([x, y+1])
	return valid_neighbors
