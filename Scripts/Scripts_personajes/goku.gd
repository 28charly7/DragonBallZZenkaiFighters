extends Node2D
#@onready var anim_tree = $AnimationTree
#@onready var state_machine = $AnimationTree.get("parameters/playback")
#
#var input_vector
#
#func set_blend_position(vector):
	#anim_tree.set("parameters/Preparado/blend_position", vector)
	#anim_tree.set("parameters/Cargar/blend_position", vector)
		#
#
#func _on_player_control_do_attack() -> void:
	#pass # Replace with function body.
#
#
#func _on_player_control_do_move(incoming_input_vector: Variant) -> void:
	#input_vector = incoming_input_vector
	#set_blend_position(input_vector)
	#if input_vector == Vector2.ZERO:
		#state_machine.travel("Preparado")
	#else:
		#if input_vector.x > 0:
			#state_machine.travel("Dash1_1") 
		#elif input_vector.x < 0:
			#state_machine.travel("Dash1_2") 
