extends Camera2D

onready var timer = $Timer

export var ACCELERATION = 20
export (NodePath) var target = null
var man1 = null
var man2 = null

export var amplitude = 6.0
export var duration = 0.2
export var DAMP_EASING = 1.0
export var shake = false

func _ready():
	for shaker in get_tree().get_nodes_in_group("shaker"):
		shaker.connect("shake_requested", self, "_on_shake_requested")
	
	set_process(false)
	timer.wait_time = duration
	
	if target != null:
		set_physics_process(true)
		man1 = get_node(target).get_node("Man")
		man2 = get_node(target).get_node("Man2")
	else:
		set_physics_process(false)

func _process(delta):
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	offset = Vector2(rand_range(amplitude, -amplitude) * damping, rand_range(amplitude, -amplitude) * damping)

func _physics_process(delta):
	global_position.x = (man1.global_position.x + man2.global_position.x) / 2.0
	global_position.y = (man1.global_position.y + man2.global_position.y) / 2.0
	return
	global_position.x = lerp(global_position.x, (man1.global_position.x + man2.global_position.x) / 2.0, ACCELERATION)
	global_position.y = lerp(global_position.y, (man1.global_position.y + man2.global_position.y) / 2.0, ACCELERATION)

func _on_shake_requested(amplitude):
	shake = true
	timer.start()
	set_process(true)

func _on_Timer_timeout():
	shake = false
	timer.stop()
	set_process(false)
