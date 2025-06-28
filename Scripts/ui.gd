extends Control

@onready var contenedorPersonajes = $CenterContainer/Personajes
@onready var personaje_p1 = $PersonajeJugador1
@onready var selector = $CenterContainer/Personajes/Selector

const COLUMNAS = 4
var personajes := []
var indiceActual := 0

var seleccion_p1 : bool = true

var personajesImagenes := [
	load("res://Personajes/Seleccion/GokuP1.png"),
	load("res://Personajes/Seleccion/VegetaP1.png"),
	load("res://Personajes/Seleccion/GohanP1.png"),
	load("res://Personajes/Seleccion/TrunksP1.png"),
	load("res://Personajes/Seleccion/FriezaP1.png"),
	load("res://Personajes/Seleccion/KidBuuP1.png"),
	load("res://Personajes/Seleccion/BrolyP1.png"),
	load("res://Personajes/Seleccion/CellP1.png")
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
		if (indiceActual + 1) % COLUMNAS != 0 and indiceActual + 1 < personajes.size():
			indiceActual += 1
			actualizarSelector()
	elif event.is_action_pressed("ui_left"):
		if indiceActual % COLUMNAS != 0:
			indiceActual -= 1
			actualizarSelector()
	elif event.is_action_pressed("ui_down"):
		if indiceActual + COLUMNAS < personajes.size():
			indiceActual += COLUMNAS		
			actualizarSelector()
	elif event.is_action_pressed("ui_up"):
		if indiceActual - COLUMNAS >= 0:
			indiceActual -= COLUMNAS
			actualizarSelector()
	elif event.is_action_pressed("ui_accept"):
		seleccion_personaje()

func seleccion_personaje():
	var nombre_personaje = personajes[indiceActual].name
	if seleccion_p1:
		Global.personaje_p1 = nombre_personaje
		seleccion_p1 = false
		indiceActual = 0
		actualizarSelector()
	else:
		Global.personaje_p2 = nombre_personaje
		get_tree().change_scene_to_file("res://Scenes/pantalla_juego.tscn")
#
#func obtener_personaje() -> String:
	#match indiceActual:
		#0: return "Goku"
		#1: return "Vegeta"
		#2: return "Gohan"
		#3: return "Trunks"
		#4: return "Frieza"
		#5: return "KidBuu"
		#6: return "Broly"
		#7: return "Cell"
		#_: return ""
	#
