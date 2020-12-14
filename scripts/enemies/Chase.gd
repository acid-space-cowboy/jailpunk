extends "res://scripts/State.gd"

onready var raycast = owner.get_node("VisionRay")
onready var vision_area = owner.get_node("VisionArea")

var path = []
var path_i = 0

export var att_dist = 50

func enter():
	owner.anim.play("walk")
	if owner.target == null:
		emit_signal("finished", "patrol")
	else:
		_on_repath_timeout()

func update(delta):
	var dir = move_along_path()
	
	if dir != null:
		var force = dir.normalized() * owner.ACCELERATION
		owner.apply_central_impulse(force)
		
		owner.hitbox.look_at(owner.hitbox.global_position + dir)
		owner.visionarea.look_at(owner.visionarea.global_position + dir)
		
		if dir.x > 0:
			owner.get_node("Sprite").flip_h = true
		else:
			owner.get_node("Sprite").flip_h = false

func move_along_path():
	var move_vec = null
	if path_i < path.size():
		move_vec = path[path_i] - owner.global_position
		if move_vec.length() < 10:
			path_i += 1
			return move_along_path()
		else:
			move_vec = path[path_i] - owner.global_position
			move_vec = move_vec.normalized()
			return move_vec

func exit():
	$repath.stop()

func _on_repath_timeout():
	if owner.global_position.distance_to(owner.target.global_position) < att_dist:
		emit_signal("finished", "action1")
		return
	
	var space_state = owner.get_world_2d().direct_space_state
	var ray_coll = space_state.intersect_ray(owner.global_position, owner.target.global_position, [self],
	raycast.collision_mask)
	
	if not ray_coll.has("collider"):
		$repath.start.start(.25)
		return
	
	if owner.navigation != null and ray_coll.collider == owner.target:
		path = owner.navigation.get_simple_path(owner.global_position, owner.target.global_position)
		path_i = 0
		$repath.start(.25)
	elif not vision_area.get_overlapping_bodies().has(owner.target):
		emit_signal("finished", "patrol")
