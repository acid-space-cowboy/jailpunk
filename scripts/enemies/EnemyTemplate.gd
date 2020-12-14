extends RigidBody2D

signal shake_requested

onready var anim = $AnimationPlayer
onready var hitbox = $hitbox
onready var visionarea = $VisionArea

export var ACCELERATION = 350

export var max_health = 2
onready var health = max_health
var staggered = false

export var patrolpath = []

var target = null # reference to target
var navigation

func _ready():
	$StateMachine/Patrol.patrolpath = patrolpath
	
	navigation = get_tree().get_nodes_in_group("navigation")
	if navigation.size() > 0: navigation = navigation[0]
	
	$StateMachine.call_deferred("initialize", $StateMachine.START_STATE)

func reset_position(pos):
	position = pos

func take_damage(dmg, culprit = null):
	if culprit != null:
		target = culprit
	
	if not staggered and health > 0:
		health -= dmg
		$hearts.update()
		if health <= 0:
			$StateMachine._change_state("dead")
		else:
			$StateMachine._change_state("stagger")
	#		$StateMachine.initialize(push_force)
	return not staggered and health > 0

func request_shake(amount):
	emit_signal("shake_requested", amount)


func _on_deathpit_detector_body_entered(body):
	take_damage(health)
	$Sprite/Tween.interpolate_property($Sprite, "self_modulate", Color(1, 1, 1, 1), Color(0, 0, 0, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Sprite/Tween.interpolate_property($Sprite, "scale", Vector2(1, 1), Vector2(0, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Sprite/Tween.start()
