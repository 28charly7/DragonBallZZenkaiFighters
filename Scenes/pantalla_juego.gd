extends Node2D

@onready var player1 = $Player1/FigtherBody2D_P1
@onready var player2 = $Player2/FigtherBody2D_P2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player1.set_opponent(player2)
	player2.set_opponent(player1)
	print("Player1 type: ", player1)
	print("Has set_opponent? ", player1.has_method("set_opponent"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
