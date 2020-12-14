extends "res://scripts/State.gd"

export var sprite_anim_disabled = false

func enter():
	owner.anim.play("stagger")
	
	if not sprite_anim_disabled: anim_from_dir(owner.hitbox.punch_dir)
	owner.staggered = true
	owner.request_shake(5.0)

func exit():
	owner.staggered = false

func _on_animation_finished(anim_name):
	emit_signal("finished", "walk")
	
func flash_white():
	owner.get_node("Sprite").self_modulate = Color(10.0, 10.0, 10.0, 1.0)

func normal_color():
	owner.get_node("Sprite").self_modulate = Color(1.0, 1.0, 1.0, 1.0)

func anim_from_dir(dir):
	var prefix = "damage_"
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
