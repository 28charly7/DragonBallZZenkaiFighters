extends Node2D


func activate_hitbox():
	get_parent().activate_hitbox()
	
func deactivate_hitbox():
	get_parent().deactivate_hitbox()
