extends Node2D

func _ready():
	mostrarPantalla("PantallaDeInicio")

func mostrarPantalla(nombrePantalla):
	for child in get_children():
		if child is CanvasItem:
			child.visible = child.name == nombrePantalla
		
	
