extends Node2D

export (Texture) var texture setget _set_texture

onready var parent = get_parent()
var offset = Vector2(-2, 0)
var spaceX = 1

func _set_texture(value):
	# If the texture variable is modified externally,
	# this callback is called.
	texture = value #texture was changed
	update() # update the node

func _draw():
	var offsetX = (4 * parent.health) + (spaceX * (parent.health)) # amount to shift all hearts to left by
	offsetX *= .5
	for x in range(parent.health):
		var preX = (4 + spaceX) * x
		var heartPos = Vector2(preX - offsetX, 0)
		draw_texture(texture, heartPos)
