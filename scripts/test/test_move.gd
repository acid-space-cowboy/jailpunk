extends RigidBody2D

signal shake_requested

onready var anim = $AnimationPlayer
onready var sprite_anim = $SpriteAnimationPlayer
onready var hitbox = $hitbox

export var color = "blue"
export var ACCELERATION = 1

export var max_health = 4
var health = 4
var staggered = false

func _ready():
	$RichTextLabel.visible = false
	if color == "blue":
		Global.blue_man = self
		if Global.blue_health == null:
			Global.blue_health = health
		else:
			health = Global.blue_health
			$hearts.update()
			if health <= 0:
				$StateMachine.START_STATE = $StateMachine/Dead.get_path()
	if color == "red":
		Global.red_man = self
		if Global.red_health == null:
			Global.red_health = health
		else:
			health = Global.red_health
			$hearts.update()
			if health <= 0:
				$StateMachine.START_STATE = $StateMachine/Dead.get_path()
	
	$StateMachine.call_deferred("initialize", $StateMachine.START_STATE)

func revive():
	$RichTextLabel.visible = false
	$StateMachine._change_state("walk")
	$Sprite.scale = Vector2(1, 1)
	$Sprite.self_modulate = Color(1, 1, 1, 1)

func gain_health(heal):
	health += heal
	$hearts.update()
	if color == "blue":
		Global.blue_health = health
	elif color == "red":
		Global.red_health = health

func reset_position(pos):
	position = pos

func take_damage(dmg, culprit = null):
	OS.delay_msec(15)
	if not staggered and health > 0:
		health -= dmg
		$hearts.update()
		
		if health <= 0:
			$StateMachine._change_state("dead")
			$RichTextLabel.visible = true
		else:
			$StateMachine._change_state("stagger")
	#		$StateMachine.initialize(push_force)
	
	if color == "blue":
		Global.blue_health = health
	elif color == "red":
		Global.red_health = health
	
	return not staggered and health+dmg > 0

func request_shake(amount):
	emit_signal("shake_requested", amount)

# die and pull your buddy in if applicable
func _on_deathpit_detector_body_entered(body):
	if take_damage(health):
		$Sprite/Tween.interpolate_property($Sprite, "self_modulate", Color(1, 1, 1, 1), Color(0, 0, 0, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN)
		$Sprite/Tween.interpolate_property($Sprite, "scale", Vector2(1, 1), Vector2(0, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN)
		$Sprite/Tween.start()
