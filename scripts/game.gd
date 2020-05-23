extends Node2D

enum {MENU , LOADING , LOADED}

var status = MENU

var current_stage
var loaded_stage
var ref_stage 

func _ready():
	add_to_group("game")
	
func stage_selected(button):
	if status == MENU:
		status = LOADING
		current_stage = button.stage
		$interfase.hide()
		load_stage()
		$HUD/controls.show()
		status = LOADED
	
func load_stage():
	if loaded_stage != null && ref_stage.get() != null:
		loaded_stage.queue_free()
	loaded_stage = load(current_stage).instance()
	ref_stage = weakref(loaded_stage)
	add_child(loaded_stage)
	
	$HUD/countdown/anim.play("count")
	yield($HUD/countdown/anim , "animation_finished")
	get_tree().call_group("player" , "start")
func player_died():
	load_stage()

func player_victory():
	loaded_stage.queue_free()
	$interfase.show()
	$HUD/controls.hide()
	status = MENU
