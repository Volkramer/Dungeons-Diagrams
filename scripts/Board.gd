extends Node2D

export(int) var grid_width = 8
export(int) var grid_height = 8
export(int) var tile_size = 16
export(int) var offset = 1
export(int) var side_offset = 2

var Tile = preload("res://scenes/Tile.tscn")
var SideTile = preload("res://scenes/SideTile.tscn")
var ProcGen = preload("res://scenes/ProcGen.tscn")

var proc_gen = ProcGen.instance()
var grid = []
var board = []

enum {GROUND, MONSTER, WALL, CHEST}

func _ready():
	randomize()
	grid = proc_gen.procedural_generation(grid_width, grid_height)
	generate_board()
	draw_side_tile()
	draw_board()
	#print(grid)

func generate_board():
	for x in range(grid_width):
		board.append([])
		for _y in range(grid_height):
			board[x].append([])
			
func draw_board():
	for x in range(grid_width):
		for y in range(grid_height):
			var pos = calc_pixel_pos_tileboard(x, y)
			var tile = Tile.instance()
			var tile_nbr = grid[x][y]
			match (tile_nbr):
				WALL:
					tile.set_tile_to_wall()
				MONSTER:
					tile.set_tile_to_monster()
				CHEST:
					tile.set_tile_to_chest()
				_:
					tile.set_tile_to_ground()
			tile.position = Vector2(pos)
			add_child(tile)
			board[x][y] = tile.tile_nbr

func draw_side_tile():
	for x in range(grid_width):
		var side_tile = SideTile.instance()
		var side_pos_x = Vector2(x * (offset + tile_size) + tile_size + side_offset, 0)
		var wall_nbr = 0
		side_tile.position = Vector2(side_pos_x)
		for y in range(grid_height):
			if(grid[x][y] == WALL):
				wall_nbr += 1
		side_tile.get_node("Label").text = str(wall_nbr)
		add_child(side_tile)
		
	for y in range(grid_height):
		var side_tile = SideTile.instance()
		var side_pos_y = Vector2(0, y * (offset + tile_size) + tile_size + side_offset)
		var wall_nbr = 0
		side_tile.position = Vector2(side_pos_y)
		for x in range(grid_width):
			if(grid[x][y] == WALL):
				wall_nbr += 1
		side_tile.get_node("Label").text = str(wall_nbr)
		add_child(side_tile)

func center_camera():
	var scale = Vector2(grid_width * (offset + tile_size) + 2 * tile_size + side_offset, grid_width * (offset + tile_size) + 2 * tile_size + side_offset)
	$Camera2D.transform.scaled(scale)

func calc_pixel_pos_tileboard(x, y):
	return Vector2(x * (offset + tile_size) + tile_size + side_offset, y * (offset + tile_size) + tile_size + side_offset)
