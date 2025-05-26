extends Control

@onready var contenedorPersonajes = $CenterContainer/Personajes
@onready var personaje_p1 = $PersonajeJugador1
@onready var selector = $CenterContainer/Personajes/Selector

var personajes := []
var indiceActual := 0
var personajesImagenes := [
	load("res://Personajes/Seleccion/GokuP1.png"),
	load("res://Personajes/Seleccion/VegetaP1.png")
] 

func _ready():
	size = get_viewport_rect().size
	personajes = contenedorPersonajes.get_children().filter(func(n): return n != selector)
	await get_tree().process_frame  
	actualizarSelector()
	
	
func actualizarSelector():
	var personaje = personajes[indiceActual]
	
	selector.position = personaje.position
	selector.size = personaje.size
	selector.visible = true
	selector.z_index = 10
	
	if (indiceActual < personajesImagenes.size()):
		personaje_p1.texture = personajesImagenes[indiceActual]
	else:
		personaje_p1.texture = null
func _unhandled_input(event):
	if event.is_action_pressed("ui_right"):
		indiceActual = (indiceActual + 1) % personajes.size()
		actualizarSelector()
	elif event.is_action_pressed("ui_left"):
		indiceActual = (indiceActual - 1 + personajes.size()) % personajes.size()
		actualizarSelector()
