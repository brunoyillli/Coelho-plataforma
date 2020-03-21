extends KinematicBody2D

const velX = 500
const grav = 1500
var velocity = Vector2(0, 0)
var jump  = false
func _ready():
	set_process_input(true)
	

func _physics_process(delta):
	velocity.y += grav * delta
	velocity.x = velX
	velocity = move_and_slide(velocity,Vector2(0,-1))
	
	if is_on_floor():
		$sprite.play("walk")
		if jump:
			velocity.y = -800
	else:
		$sprite.play("jump")		
	jump = false

func _input(event):
	if event is InputEventScreenTouch:
		if  event.is_pressed():
			jump = true
