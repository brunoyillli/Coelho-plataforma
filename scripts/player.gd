extends KinematicBody2D

const grav = 1500
var velocity = Vector2(500, 0)
func _ready():
	pass

func _physics_process(delta):
	velocity.y += grav * delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	pass
