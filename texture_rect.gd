extends TextureRect

var personajes = []

var seleccionado = 0
var columna = 0
var fila = 0

@export var player1Text: Texture
@export var player2Text: Texture
@export var cantidadFilas: int = 2
@export var desplazamientoVertical: Vector2

@onready var gridContainer = get_tree().get_root().get_node("SeleccionPersonajes/Control/GridContainer")

func _ready():
	for nombrePersonaje in get_tree().get_nodes_in_group("Personajes"):
		personajes.append(nombrePersonaje)
	
	texture = load("res://Fondos/BordeSeleccion.png")
	size = Vector2(64, 64)
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_right") and seleccionado < personajes.size() - 1):
		seleccionado += 1
		columna += 1	
		
		_update_cursor_position()
		print("derecha")
	elif (Input.is_action_just_pressed("ui_left") and seleccionado > 0):
		seleccionado -= 1
		columna -= 1	
		
		_update_cursor_position()
		print("izquierda")

func _update_cursor_position():
	if seleccionado >= 0 and seleccionado < personajes.size():
		var personaje_pos = personajes[seleccionado].position
		position = personaje_pos - size / 2

		print("Nueva posición del selector:", position)
