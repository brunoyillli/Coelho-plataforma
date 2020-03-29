extends KinematicBody2D

const velX = 800
const grav = 1500
var velocity = Vector2(0, 0)
var jump  = false
var jump_release = false
var was_on_floor = false
var controled_jump = false
onready var mask = collision_mask
onready var layer = collision_layer


enum {IDLE , RUNNING , FLYING , DEAD}

var status = RUNNING

func _ready():
	set_process_input(true)
	

func _physics_process(delta):
	
	if status == RUNNING:
		running(delta)
	elif status == DEAD:
		dead(delta)
		
	if status != DEAD:
		if position.y > ProjectSettings.get_setting("display/window/size/height"):
			killed()
		
	jump = false
	jump_release = false

func running(delta):
	velocity.y += grav * delta
	velocity.x = velX
	velocity = move_and_slide(velocity,Vector2(0,-1))
	
	if is_on_floor():
		if not was_on_floor:
			$anim_lander.play("boing")
			$dust/anim.play("dust")
		$sprite.play("walk")
		if jump:
			jump(1000, true)
			$jump.play()
	else:
		$sprite.play("jump")
		if jump_release and velocity.y < 0 and controled_jump:
			velocity.y *= .3
			
	was_on_floor = is_on_floor()

func dead(delta):
	$sprite.play("hurt")
	translate(velocity * delta)
	velocity.y += grav * delta
	
func _input(event):
	if event is InputEventScreenTouch:
		if  event.is_pressed():
			jump = true
		else:
			jump_release = true

func jump(force, controled):
	velocity.y = -force
	controled_jump = controled
	
func killed():
	if status != DEAD:
		status = DEAD
		collision_mask = 0
		collision_layer = 0
		velocity = Vector2(0 , -1000)
		$dead.play()
