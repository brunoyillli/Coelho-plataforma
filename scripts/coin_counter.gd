extends Node2D

var coins = 0 

func _ready():
	add_to_group("coin_counter")
	update_label()
	
	
func pick_coin():
	coins += 1
	update_label()

func update_label():
	$coins.text = str(coins)
