extends Node2D

export var tile_nbr: int

func set_tile_to_ground():
	$Chest.hide()
	$Ground.show()
	$Monster.hide()
	$Wall.hide()
	tile_nbr = 0

func set_tile_to_wall():
	$Chest.hide()
	$Ground.hide()
	$Monster.hide()
	$Wall.show()
	tile_nbr = 2

func set_tile_to_chest():
	$Chest.show()
	$Ground.show()
	$Monster.hide()
	$Wall.hide()
	tile_nbr = 3

func set_tile_to_monster():
	$Chest.hide()
	$Ground.show()
	$Monster.show()
	$Wall.hide()
	tile_nbr = 1

func toggle_circle():
	if(!$RedCircle.visible):
		$RedCircle.show()
	else:
		$RedCircle.hide()

func is_redcircle_on():
	if($RedCircle.visible):
		return true

func is_ground():
	if(!$Chest.visible && !$Monster.visible && !$Wall.visible):
		return true

func is_wall():
	if(!$Chest.visible && !$Monster.visible && $Wall.visible):
		return true

func _on_Control_mouse_entered():
	$Highlight.show()

func _on_Control_mouse_exited():
	$Highlight.hide()

func _on_Control_gui_input(_event):
	if(Input.is_action_just_pressed("mouse_left_click") && is_ground()):
		if(is_redcircle_on()):
			toggle_circle()
		set_tile_to_wall()
		set_board_tile_nbr()
	elif(Input.is_action_just_pressed("mouse_left_click") && is_wall()):
		set_tile_to_ground()
		set_board_tile_nbr()
	elif(Input.is_action_just_pressed("mouse_right_click") && is_ground()):
		toggle_circle()
	elif(Input.is_action_just_pressed("mouse_right_click") && is_wall()):
		set_tile_to_ground()
		toggle_circle()
	else:
		pass

func calc_reverse_pos():
	var board = get_parent()
	var pos_x = position[0]/(board.offset + board.tile_size)
	var pos_y = position[1]/(board.offset + board.tile_size)
	return [pos_x, pos_y]
	
func set_board_tile_nbr():
	var board = get_parent()
	var reverse_pos = calc_reverse_pos()
	board.board[reverse_pos[0]][reverse_pos[1]]=tile_nbr
	print(board.board)
	print(board.grid)
	
