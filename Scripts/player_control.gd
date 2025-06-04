extends Node2D

@export var body: CharacterBody2D
@export var step_speed := 300
@export var step_distance := 50

var is_stepping := false
var target_position := Vector2.ZERO


func _physics_process(delta: float) -> void:
	if body == null:
		return
	
	if is_stepping:
		move_to_target(delta)
	else: 
		handle_input()
	
func handle_input():
	if Input.is_action_just_pressed("ui_left"):
		start_step(Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_right"):
		start_step(Vector2.RIGHT)
		
func start_step(direction: Vector2):
	is_stepping = true
	target_position = body.global_position + direction * step_distance
	
func move_to_target(delta: float):
	var direction = (target_position - body.global_position).normalized()
	var distance_left = body.global_position.distance_to(target_position)
	var step = delta * step_speed
	
	if step >= distance_left:
		body.global_position = target_position
		is_stepping = false
	else:
		body.global_position += direction * step
	body.move_and_slide()
