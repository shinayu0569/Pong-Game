extends CharacterBody2D

var initial_x = position.x
@export var speed: float = 300.0

func _physics_process(delta: float):
	if position.x != initial_x:
		position.x = initial_x
	
	if Input.is_action_pressed("m_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("m_down"):
		velocity.y = speed
	else:
		velocity.y = 0
	move_and_slide()
	
	# Clamp the paddle within screen bounds
	position.y = clamp(position.y, 50, 550)
