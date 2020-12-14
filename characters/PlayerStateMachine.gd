extends "res://scripts/StateMachine.gd"

"""
# Determines Player's actions based on input and current action / state
"""

func _ready():
	states_map = {
		"walk": $Walk,
		"stagger": $Stagger,
		"action1": $Basic,
		"action2": $Special,
		"dead": $Dead
	}

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	
	Here does mostly initializing
	"""
	if not _active:
		return
	if state_name in ["dead","stagger"]:
		states_stack.push_front(states_map[state_name])
#	# If state_name is a motion state, we gotta initialize based on current_state
#	if state_name in ["jump", "stagger", "dead", "action1", "action2", "move", "idle", "in_air", "swim"] and "velocity" in current_state:
#		states_map[state_name].initialize(current_state.velocity)
	._change_state(state_name)

func _input(event):
	"""
	Here we only handle input that can interrupt states, attacking in this case
	otherwise we let the state node handle it
	"""
#	if event.is_action_pressed("action1"):
#		if current_state in [$Dead, $Dash, $Strong, $Special, $Basic, $Stagger]:
#			return
#		_change_state("action1")
#		return
#	elif event.is_action_pressed("action2"):
#		if current_state in [$Dead, $Dash, $Strong, $Special, $Basic, $Stagger]:
#			return
#		_change_state("action2")
#		return
	current_state.handle_input(event)

func set_dead(value):
	_active = not value

func _on_AnimationPlayer_animation_finished(anim_name):
	._on_animation_finished(anim_name)

#func _on_HitArea_landed_hit():
#	return
#	if current_state.has_method("play_hit"):
#		current_state.play_hit()
#
#func _on_Stats_health_depleted():
#	._change_state("dead")
