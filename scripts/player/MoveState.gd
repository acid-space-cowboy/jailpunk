extends "res://scripts/State.gd"

func get_input():
	var dir = Vector2()
	var prefix = owner.color + "_"
	if Input.is_action_pressed(prefix+"right"):
		dir.x += 1
	if Input.is_action_pressed(prefix+"left"):
		dir.x -= 1
	if Input.is_action_pressed(prefix+"up"):
		dir.y -= 1
	if Input.is_action_pressed(prefix+"down"):
		dir.y += 1
	
	if dir != Vector2():
		dir = dir.normalized()
	return dir
