extends Area2D


func _ready():
	pass


func _on_coin_body_entered(body):
	$fx.play()
	$sprite.visible = false
	collision_mask = 0
	$queu_timer.start()
	$particles.emitting = true
	get_tree().call_group("coin_counter", "pick_coin")

func _on_queu_timer_timeout():
	queue_free()
