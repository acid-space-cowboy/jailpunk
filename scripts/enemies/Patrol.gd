extends "res://scripts/State.gd"

export (Array) var patrolpath = []
var patrol_i = 0 # different from path_i in that this determines the patrol point we are heading towards
var path = []
var path_i = 0

onready var raycast = owner.get_node("VisionRay")

func _ready():
#	patrolpath = owner.patrolpath
#	print(patrolpath)
	pass

func enter():
	_on_repath_timeout()
	owner.anim.play("idle")

func exit():
	$repath.stop()

func update(delta):
	var dir = move_along_path()
	
	if dir != null:
		owner.anim.play("walk")
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
	elif patrolpath.size() > 1:
		patrol_i += 1
		patrol_i %= patrolpath.size()
		_on_repath_timeout()

func _on_repath_timeout():
	if owner.navigation != null and  patrolpath.size() > 0:
		if owner.get_node(patrolpath[patrol_i]) != null:
			path = owner.navigation.get_simple_path(owner.global_position, owner.get_node(patrolpath[patrol_i]).global_position)
		path_i = 0
		$repath.start(.25)

func _on_VisionArea_body_entered(body):
	if not get_parent().current_state == self:
		return
	
	var space_state = owner.get_world_2d().direct_space_state
	var ray_coll = space_state.intersect_ray(owner.global_position, body.global_position, [self],
	raycast.collision_mask)
	
	if ray_coll.collider == body:
		owner.target = body
		emit_signal("finished", "chase")
