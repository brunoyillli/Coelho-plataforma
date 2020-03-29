extends Node2D

onready var size = $bar.rect_size

func _ready():
	add_to_group("power_up_bar")
	visible = false #ou hide()
	pass

func start(time):
	visible = true #ou show()
	$tween.interpolate_method(self , "count" , 1 , 0 , time , Tween.TRANS_LINEAR , Tween.EASE_IN , 0)
	$tween.start()

func stop():
	$tween.stop_all()
	visible = false
	
func count(val):
	$bar.rect_size = Vector2(size.x * val,size.y)


func _on_tween_tween_completed(object, key):
	stop()
	get_tree().call_group("player" , "powerup_finished")
