extends CharacterBody2D

const STEP_DISTANCE = 80 
const JUMP_FORCE = -400
const GRAVITY = 1000 

@onready var sprite_holder = $SpriteHolder
@onready var animation_tree: AnimationTree = null
@export var fighter_name: String = "Default"

var state_machine = null

var target_position = Vector2.ZERO
var moving = false

func _ready():
	#load_character("res://Scenes/PersonajesScenes/goku.tscn")
	match fighter_name:
		"Goku":
			load_character("res://Scenes/PersonajesScenes/goku.tscn")
		"Vegeta":
			load_character("res://Scenes/PersonajesScenes/vegeta.tscn")
			
	target_position = global_position
	moving = false
	
func _physics_process(delta):
	if not moving and global_position != target_position:
		target_position = global_position
	var is_jumping = false 
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		is_jumping = true
	else:
		if Input.is_action_just_pressed("ui_up"):
			print("salto")
			velocity.y = JUMP_FORCE
			is_jumping = true
	
	if not moving:
		if Input.is_action_just_pressed("ui_right"):
			print("derecha")
			target_position.x += STEP_DISTANCE
			moving = true
		elif Input.is_action_just_pressed("ui_left"):
			print("izquierda")
			target_position.x -= STEP_DISTANCE 
			moving = true
	
	if is_jumping:
		print("Saltando")
		state_machine.travel("Salto")	
	elif moving:
		var direction = (target_position - global_position).normalized()
		var distance = global_position.distance_to(target_position)

		if distance < 1.0:
			global_position = target_position
			velocity.x = 0
			moving = false
		else:
			velocity.x = direction.x * 400  
			if animation_tree:
				if direction.x > 0:
					state_machine.travel("Dash1_1")
				else:
					state_machine.travel("Dash1_2")
	else:
		if animation_tree:
			state_machine.travel("Preparado")
	move_and_slide()
	

func load_character(path: String):
	var character_scene = load(path)
	if not character_scene:
		push_error("error de carga de personaje" + path)
		return
	
	for child in sprite_holder.get_children():
		child.queue_free()
	
	var character = character_scene.instantiate()
	character.position = Vector2.ZERO
	sprite_holder.add_child(character)
	
	animation_tree = character.get_node("AnimationTree")
	animation_tree.active = true
	state_machine = animation_tree.get("parameters/playback")
