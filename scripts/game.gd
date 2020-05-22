extends Node2D


func _ready():
	add_to_group("game")
	
func stage_selected(button):
	print(button.stage)
