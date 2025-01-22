extends CharacterBody2D

@export var speed: float = 300.0 # Slightly less than the player paddle speed for fairness
@export var reaction_time: float = 0.2 # Delay in seconds before the AI reacts
@export var error_margin: float = 10.0 # AI's imprecision margin

var initial_x = position.x
var target_y: float = 0.0
var reaction_timer: float = reaction_time

func _physics_process(delta: float):
	if position.x != initial_x:
		position.x = initial_x
	
	# Track the ball only after the reaction time has passed
	reaction_timer -= delta
	if reaction_timer <= 0:
		var ball = get_parent().get_node("ball") # Adjust if the ball's node is named differently
		target_y = ball.position.y + randf_range(-error_margin, error_margin)
		reaction_timer = reaction_time
	
	# Move towards the target_y, but not instantly
	if position.y < target_y:
		velocity.y = lerp(velocity.y, speed, 0.2)
	elif position.y > target_y:
		velocity.y = lerp(velocity.y, -speed, 0.2)
	else:
		velocity.y = 0
	
	move_and_slide()

	# Clamp the paddle within screen bounds
	position.y = clamp(position.y, 50, 550)
