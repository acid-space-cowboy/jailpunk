extends Node2D

"""
Player initialization as well as chain initialization
"""

const LEFTMAN = preload("res://characters/Man.tscn")
const RIGHTMAN = preload("res://characters/Man.tscn")
const LOOP = preload("res://assets/chain/loop.tscn")
const LINK = preload("res://assets/chain/link.tscn")

export var chainlength = 20
export var looplength = 12

var leftman
var rightman
onready var chain = $Chain


func _input(event):
	if event.is_action_pressed("restart"):
		Global.blue_man = null
		Global.red_man = null
		Global.blue_health = null
		Global.red_health = null
		get_tree().reload_current_scene()
#func _ready():
#	leftman = LEFTMAN.instance()
#	leftman.position = Vector2()
#	add_child(leftman)
#
#	var parent = leftman.get_node("Loop")
#	for i in range(chainlength):
#		var next = create_loop(parent.position)
#
#func create_loop(pos):
#	var loop = LOOP.instance()
#	loop.position = pos
#	loop.position += looplength
#	add_child(loop)
	
