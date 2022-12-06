extends Node2D

func set_tile_to_ground():
	$Chest.hide()
	$Ground.show()
	$Monster.hide()
	$Wall.hide()

func set_tile_to_wall():
	$Chest.hide()
	$Ground.hide()
	$Monster.hide()
	$Wall.show()

func set_tile_to_chest():
	$Chest.show()
	$Ground.show()
	$Monster.hide()
	$Wall.hide()

func set_tile_to_monster():
	$Chest.hide()
	$Ground.show()
	$Monster.show()
	$Wall.hide()

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

func _on_Control_gui_input(event):
	if(Input.is_action_just_pressed("mouse_left_click") && is_ground()):
		if(is_redcircle_on()):
			toggle_circle()
		set_tile_to_wall()
	elif(Input.is_action_just_pressed("mouse_left_click") && is_wall()):
		set_tile_to_ground()
	elif(Input.is_action_just_pressed("mouse_right_click") && is_ground()):
		toggle_circle()
	elif(Input.is_action_just_pressed("mouse_right_click") && is_wall()):
		set_tile_to_ground()
		toggle_circle()
	else:
		pass
