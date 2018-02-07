extends KinematicBody2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var screen_size
var char_size
var direction = 0
var input_direction = 0
const GRAVITY = 9800
const jump_strength = 150
var speed_x = 0
var speed_y = 0
var collided = false
var velocity = Vector2()
const ACCELRATION = 100
const DECCELRATION = 100
const MAX_SPEED = 250

# Constant for char
const char_speed = 200

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	move( motion )
	
func _input(event):
	if (event.is_action_pressed("jump") and collided):
		speed_y = -jump_strength

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	set_process(true)
	pass
	
func _process(delta):
	#Input
	if is_colliding():
		collided = true
	else:
		collided = false
				
	if Input.is_action_pressed("move_right"):
		input_direction = 1
	elif Input.is_action_pressed("move_left"):
		input_direction = -1
	else:
		input_direction = 0
		
	#Movement
	if direction == input_direction:
		#Accelerate if the direction is the same as the key pressed
		speed_x += (ACCELRATION + speed_x) / 3
	elif direction == -input_direction:
		#Deccelerate if the direction is the opposite of the pressed key
		speed_x -= DECCELRATION + (speed_x / 3) 
	else:
		#Deccelerate at a slower pace if the no key is
		# pressed but the char is still moving
		speed_x -= DECCELRATION
	
	#Change the direction only if the character has stopped moving and
	# if the speed was brought to the negative side bring it back up to zero
	if direction != input_direction and speed_x <= 0:
		speed_x = 0
		direction = input_direction
	
	if speed_x > MAX_SPEED:
		speed_x = MAX_SPEED
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y
	speed_y = 0
	move(velocity)
	
	
	
