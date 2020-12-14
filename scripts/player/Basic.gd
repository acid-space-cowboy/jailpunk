extends "res://scripts/State.gd"

export var punch_accel = 200

func enter():
	owner.anim.play("punch")
	
	owner.apply_central_impulse(owner.hitbox.punch_dir.normalized() * punch_accel)
	anim_from_dir(owner.hitbox.punch_dir)
	owner.hitbox.look_at(owner.hitbox.global_position + owner.hitbox.punch_dir)

func _on_animation_finished(anim_name):
	emit_signal("finished", "walk")

func anim_from_dir(dir):
	var prefix = "punch_"
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
			if(dir.y == 1):
				owner.sprite_anim.play(prefix+"down")
			else:
				owner.sprite_anim.play(prefix+"up")
