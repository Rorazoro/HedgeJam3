extends KinematicBody2D

# the movement variables (mess around with them to make the movement the way you like)
export (float) var FACTOR = 2.5
var MAX_SPEED = 90
var FRICTION = 900 
var ACCEL = 1000 

export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

# geting player input with our own function
func get_input(delta):
	var x_dir = Input.get_axis("move_left", "move_right")
	var y_dir = Input.get_axis("move_up", "move_down")
	# 6 frame acceleration?? (Not sure if i remember 
	# how to check this, but fingers crossed
	if abs(velocity.x) >= MAX_SPEED * FACTOR and sign(velocity.x) == x_dir:
		velocity.x = move_toward(velocity.x, x_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta)
	else:
		velocity.x = move_toward(velocity.x, x_dir * MAX_SPEED * FACTOR , ACCEL * FACTOR * delta)	
	if abs(velocity.y) >= MAX_SPEED * FACTOR and sign(velocity.y) == y_dir:
		velocity.y = move_toward(velocity.y, y_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta)
	else:
		velocity.y = move_toward(velocity.y, y_dir * MAX_SPEED * FACTOR , ACCEL * FACTOR * delta)
	if (abs(velocity.x) >= MAX_SPEED * FACTOR and abs(velocity.y) >= MAX_SPEED * FACTOR ) and (sign(velocity.x) == x_dir and sign(velocity.y) == y_dir):
		velocity.x = move_toward(velocity.x, x_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta) / 2
		velocity.y = move_toward(velocity.y, y_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta) / 2
# and finaly calculating the movement
func _physics_process(delta):
	get_input(delta)
#	velocity.y += gravity * delta
	print(velocity)
	velocity = move_and_slide(velocity)
