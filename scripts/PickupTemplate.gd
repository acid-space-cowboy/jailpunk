extends KinematicBody2D

export var health_boost = 0
export var revive = false

func _ready():
	$AnimationPlayer.play("bo")
