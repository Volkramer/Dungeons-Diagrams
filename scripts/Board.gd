extends Node2D

export(int) var grid_width = 8
export(int) var grid_height = 8
export(int) var tile_size = 16
export(int) var offset = 1

var tiles = preload("res://scenes/Tile.tscn")

var grid = []
var board = []

func _ready():
	generate_grid()
	draw_board()
	print(grid)

func generate_grid():
	for x in range(grid_width):
		grid.append([])
		board.append([])
		for y in range(grid_height):
			grid[x].append([])
			board[x].append([])
			grid[x][y] = randi() % 4 

func draw_board():
	for x in range(grid_width):
		for y in range(grid_height):
			var pos = calc_pixel_pos(x, y)
			var tile = tiles.instance()
			var tile_nbr = grid[x][y]
			match (tile_nbr):
				1:
					tile.set_tile_to_monster()
				3:
					tile.set_tile_to_chest()
				_:
					tile.set_tile_to_ground()
			tile.position = Vector2(pos)
			add_child(tile)
			board[x][y] = tile.tile_nbr
	print(board)

func calc_pixel_pos(x, y):
	return Vector2(x * (offset + tile_size), y * (offset + tile_size))
	

