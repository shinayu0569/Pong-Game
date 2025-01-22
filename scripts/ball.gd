extends CharacterBody2D

@export var speed: float = 300.0
var direction = Vector2.ONE.normalized()  # Initial direction
var colliding: int = 0
var bouncing_modifier = 1.1

var initial_x
var initial_y

@onready var win_ai: Area2D = $"../winning_area/win_ai"
@onready var win_human: Area2D = $"../winning_area/win_human"
@onready var main: Node2D = $".."


func _ready():
	# Randomize initial direction
	direction = Vector2(randf_range(-1, 1), randf_range(-0.5, 0.5)).normalized()
	initial_x = position.x
	initial_y = position.y

func _physics_process(_delta: float):
	# Move the ball
	velocity = direction * speed
	move_and_slide()

	# Bounce off top and bottom walls
	if position.y <= 10 or position.y >= (576-10):
		bouncing_modifier += 0.1
		direction.y = -(direction.y*bouncing_modifier)
		direction.x += sign(direction.x)*bouncing_modifier
		direction = direction.normalized()

	# Normalize direction to maintain consistent speed
	direction = direction.normalized()
	colliding = 0
	

func _on_collision_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Paddles") and colliding == 0:
		direction.y = randf_range(-0.5, 0.5)
		if (sign(direction.x) == 1):
			direction.x = randf_range(-0.1, -0.5)
		elif (sign(direction.x) == -1):
			direction.x = randf_range(0.1, 0.5)
		colliding = 1
		
		
func _on_collision_area_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	colliding = 0


func _on_win_ai_body_entered(body: Node2D) -> void:
	
	main.c_score += 1
	position.x = initial_x
	position.y = initial_y
	pass # Replace with function body.


func _on_win_human_body_entered(body: Node2D) -> void:
	
	main.p_score += 1
	position.x = initial_x
	position.y = initial_y
	pass # Replace with function body.
