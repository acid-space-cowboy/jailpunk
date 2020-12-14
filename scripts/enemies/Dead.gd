extends "res://scripts/State.gd"


func enter():
	owner.anim.play("dead")
	owner.get_node("CollisionShape2D").set_deferred("disabled", true)
#	owner.get_node("Sprite").self_modulate = Color(0, 0,0 , 0)
#	owner._on_deathpit_detector_body_entered(owner.target)
