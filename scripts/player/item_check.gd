extends Area2D


func _on_item_check_body_entered(body):
	if body.revive:
		if Global.blue_man.health <= 0:
			Global.blue_man.revive()
			Global.blue_man.gain_health(body.health_boost)
		elif Global.red_man.health <= 0:
			Global.red_man.revive()
			Global.red_man.gain_health(body.health_boost)
		else:
			return
	else:
		owner.gain_health(body.health_boost)
	
	body.queue_free()
