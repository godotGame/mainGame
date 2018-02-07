extends Node2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var screen_size
var char_size
var direction = Vector2(1.0, 0.0)
const GRAVITY = 600
var velocity = Vector2()
const jump_strength = -600
var jump_vel = Vector2()
var jumped = false

# Constant for char
const char_speed = 200

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	var char = get_node("char")
	var motion = velocity * delta
	char.move( motion )

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	char_size = get_node("char/Sprite").get_texture().get_size()
	set_fixed_process(true)
	set_process(true)
	pass

func _process(delta):
	# Move left pad
	var char = get_node("char")
	var char_pos = char.get_pos()
	
	
	if (char_pos.y > 0 and Input.is_action_pressed("move_up")):
	    char_pos.y += -char_speed * delta
	if (char_pos.y < screen_size.y and Input.is_action_pressed("move_down")):
	    char_pos.y += char_speed * delta
	if (char_pos.x > 0 and Input.is_action_pressed("move_left")):
		char_pos.x += -char_speed * delta
	if (char_pos.x < screen_size.x and Input.is_action_pressed("move_right")):
		char_pos.x += char_speed * delta
	if (!jumped and Input.is_action_pressed("jump")):
		jump_vel.y = -jump_strength * delta
		char.move(jump_vel)
	
	get_node("char").set_pos(char_pos)
	