extends "res://scripts/State.gd"


func enter():
	owner.sprite_anim.play("dead")
	owner.get_node("die").play()
