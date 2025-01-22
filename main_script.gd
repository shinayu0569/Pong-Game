extends Node2D

@export var p_score = 0
@export var c_score = 0

@onready var player_score: Label = $player_score
@onready var ai_score: Label = $ai_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_score.text = str(p_score)
	ai_score.text = str(c_score)
	pass
