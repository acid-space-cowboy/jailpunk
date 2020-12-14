extends Area2D

export var effects_enabled = false
export var punch_force = 2000
var punch_dir = Vector2(1, 0)

func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		var took_damage = body.take_damage(1, owner)
		if took_damage:
			if effects_enabled:
				OS.delay_msec(15)
				owner.request_shake(2.0)
			body.apply_central_impulse(punch_force * punch_dir.normalized()) # apply a force away from hitbox
