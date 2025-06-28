extends Node2D

var audio: AudioStreamPlayer

func _ready():
	audio = AudioStreamPlayer.new()
	audio.volume_db = -10
	var stream = preload("res://soundtrack/Intro.ogg")
	stream.loop = true
	
	audio.stream = stream
	add_child(audio)
	#audio.play()
	
