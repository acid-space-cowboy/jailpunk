extends Area2D

export (String) var goto = "res://scenes/test_map2.tscn"

func _on_exit_portal_body_entered(body):
	get_tree().change_scene(goto)
