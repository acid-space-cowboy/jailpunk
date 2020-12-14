extends "res://scripts/player/MoveState.gd"

func enter():
	owner.anim.play("walk")

func update(delta):
	var dir = get_input()
	anim_from_dir(dir)
	
	if dir != Vector2():
		owner.hitbox.punch_dir = dir
	
	var force = dir.normalized() * owner.ACCELERATION
	owner.apply_central_impulse(force)

func handle_input(event):
	var prefix = owner.color + "_"
	if event.is_action_pressed(prefix+"punch"):
		emit_signal("finished", "action1")

func anim_from_dir(dir):
	var prefix = "walk_"
	if dir == Vector2():
		prefix = "idle_"
		dir = owner.hitbox.punch_dir
	match dir:
		Vector2(1, 0):
			owner.sprite_anim.play(prefix+"right")
		Vector2(0, 1):
			owner.sprite_anim.play(prefix+"down")
		Vector2(-1, 0):
			owner.sprite_anim.play(prefix+"left")
		Vector2(0, -1):
			owner.sprite_anim.play(prefix+"up")
		_:
			if(dir.y > 0):
				owner.sprite_anim.play(prefix+"down")
			else:
				owner.sprite_anim.play(prefix+"up")
