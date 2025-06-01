extends Node2D  # o Control si es UI

@onready var label = $texto_cargando

func _ready():
	label.text = "Cargando..."
	# Esperar medio segundo para que se vea la pantalla
	await get_tree().create_timer(1.5).timeout
	# Cambiar a la escena que quieres cargar
	get_tree().change_scene_to_file("res://seleccion_personajes.tscn")
