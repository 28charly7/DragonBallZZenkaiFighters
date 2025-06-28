extends CharacterBody2D

const SPEED = 300 
const JUMP_FORCE = -600
const GRAVITY = 1200 

var vida = 100

@onready var sprite_holder = $SpriteHolder
@onready var animation_tree: AnimationTree = null
@onready var raycast : RayCast2D = $RayCast2D

var state_machine = null
var opponent: CharacterBody2D

func _ready():
	var figther_name = Global.personaje_p1 
	print("Nombre del personaje: ", figther_name)
	match figther_name:
		"Goku":
			load_character("res://Scenes/PersonajesScenes/goku.tscn")
		"Vegeta":
			load_character("res://Scenes/PersonajesScenes/vegeta.tscn")
	
	await get_tree().create_timer(1.0).timeout
	state_machine.travel("Golpe_Combo1_1")
	
func _physics_process(delta):
	update_facing(opponent.global_position)
	var is_jumping = false
	var on_floor = is_on_floor()
	var facing_right = global_position.x < opponent.global_position.x
	var direction = 0
	
	if not on_floor:
		velocity.y += GRAVITY * delta
		
	if on_floor and Input.is_action_just_pressed("Arriba_P1"):
		print("salto")
		velocity.y = JUMP_FORCE
		is_jumping = true
		state_machine.travel("Salto")
		move_and_slide()
		return
	
	if Input.is_action_pressed("Derecha_P1"):
		direction = 1
	elif Input.is_action_pressed("Izquierda_P1"):
		direction = -1
	
	raycast.target_position.x = 30 * direction
	raycast.force_raycast_update()
	if raycast.is_colliding():
		direction = 0
	velocity.x = direction * SPEED
	
	if Input.is_action_pressed("Golpe_P1"):
		state_machine.travel("GolpeCombo1_1")
		return
	
	if direction == 1:
		if facing_right:
			state_machine.travel("Dash1_1")
			if Input.is_action_just_released("Derecha_P1"):
				state_machine.travel("Dash1_1end")
		else: 
			state_machine.travel("Dash1_2")
			if Input.is_action_just_released("Izquierda_P1"):
				state_machine.travel("Dash1_2end")
	elif direction == -1:
		if facing_right:
			state_machine.travel("Dash1_2") 
			if Input.is_action_just_released("Izquierda_P1"):
				state_machine.travel("Dash1_2end")
		else: 
			state_machine.travel("Dash1_1")
			if Input.is_action_just_released("Derecha_P1"):
				state_machine.travel("Dash1_1end")	
	else:
		state_machine.travel("Preparado")
		
	move_and_slide()

func update_facing(opponent_position: Vector2):
	var visual = sprite_holder.get_child(0).get_node_or_null("Visual")
	if visual:
		if opponent_position.x < global_position.x:
			visual.scale.x = -1
		else: 
			visual.scale.x = 1
	else:
		print("Visual node no enconcrado")

func set_opponent(op: CharacterBody2D):
	opponent = op

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
	
	sprite_holder.scale.x = 1
	
	animation_tree = character.get_node_or_null("Visual/AnimationTree")
	if not animation_tree:
		push_error("No se encontró AnimationTree en " + path)
		return
	
	animation_tree.active = true
	state_machine = animation_tree.get("parameters/playback")
	try_travel_fallback(["Entrada1_1", "Entrada1_2", "EntradaFinal", "Preparado"])
	
	
	var visual_node = character.get_node_or_null("Visual")
	
	if visual_node:
		character.position = Vector2.ZERO
		visual_node.name = "Visual"  
	else:
		push_error("No se encontró nodo 'Visual' en " + path)
	
func try_travel(state_name: String):
	if animation_tree and state_machine:
		if animation_tree.has_node("parameters/" + state_name):
			state_machine.travel(state_name)
		else:
			print("Animación no encontrada:", state_name)
	
func try_travel_fallback(states: Array):
	for state in states:
		if animation_tree and animation_tree.has_node("parameters/" + state):
			state_machine.travel(state)
			print("Se usó animación:", state)
			return
	print("Ninguna animación válida encontrada entre:", states)

func activate_hitbox():
	$Hitbox1/CollisionShape2D.disabled = false
	print("Hitbox1 activada")
	print("CollisionShape Hitbox disabled?: ", $Hitbox1/CollisionShape2D.disabled)

func deactivate_hitbox():
	$Hitbox1/CollisionShape2D.disabled = true
	print("Hitbox1 desactivada")
	print("CollisionShape Hitbox disabled?: ", $Hitbox1/CollisionShape2D.disabled)
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox2":
		var enemy = area.get_parent()
		if enemy.has_method("take_damage"):
			enemy.take_damage(10)

func take_damage(amount: int):
	vida -= amount
	print(vida)
	print("Me golpearon el player 1: ", vida)
	
