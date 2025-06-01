extends Node2D

@onready var progress_bar = $TextureProgressBar
@onready var label = $Label

var loader = null  # Sin tipo explícito

func _ready():
	label.text = "Cargando..."
	loader = ResourceLoader.load_interactive("res://Scenes/ui.tscn")
	set_process(true)

func _process(_delta):
	if loader == null:
		return

	var err = loader.poll()
	if err == OK:
		var stage = loader.get_stage()
		var total = loader.get_stage_count()
		var progress = float(stage) / total
		progress_bar.value = progress * 100
		label.text = "Cargando... " + str(int(progress * 100)) + "%"
	elif err == ERR_FILE_EOF:
		var scene = loader.get_resource()
		get_tree().change_scene_to_packed(scene)
		loader = null
		set_process(false)
	elif err != OK:
		label.text = "Error cargando escena"
		set_process(false)
