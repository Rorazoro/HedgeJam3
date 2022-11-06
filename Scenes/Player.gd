extends KinematicBody2D

enum {
	MOVE,
	IDLE,
	DASH,
}

#set default state
var state = IDLE

# the movement variables (mess around with them to make the movement the way you like)
export (float) var FACTOR = 2.5
var MAX_SPEED = 100
var FRICTION = 900 
var ACCEL = 1000 

export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25

var dash_acc = 20
var state_time = 0.0
export (float) var dash_time = 0.15
var dir = Vector2.ZERO
var velocity = Vector2.ZERO


func _physics_process(delta):
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	match state:
		IDLE:
			velocity = Vector2.ZERO
			#change states
			if dir.length() != 0:
				set_state(MOVE)
		DASH:
			set_dash_velocity(dir)
			move_and_slide(velocity * MAX_SPEED * FACTOR)
			#change states
			if state_time >= dash_time:
				set_state(MOVE)
		MOVE:
			set_velocity(dir)
			move_and_slide(velocity * MAX_SPEED * FACTOR)
			#change states
			if dir.length() == 0:
				set_state(IDLE)
			elif Input.is_action_just_pressed("dash"):
				set_state(DASH)
#increment time in each state by delta
	state_time += delta

func set_state(new_state):
	state = new_state
	state_time = 0.0

func set_dash_velocity(dir):
	velocity = velocity.move_toward(3 * dir,  ACCEL * dash_acc)
	
# geting player velocity based on input
func set_velocity(dir):
	#NUMBER ONE
#	var x_dir = Input.get_axis("move_left", "move_right")
#	var y_dir = Input.get_axis("move_up", "move_down")
#	# 6 frame acceleration?? (Not sure if i remember 
#	# how to check this, but fingers crossed
#	if abs(velocity.x) >= MAX_SPEED * FACTOR and sign(velocity.x) == x_dir:
#		velocity.x = move_toward(velocity.x, x_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta)
#	else:
#		velocity.x = move_toward(velocity.x, x_dir * MAX_SPEED * FACTOR , ACCEL * FACTOR * delta)	
#	if abs(velocity.y) >= MAX_SPEED * FACTOR and sign(velocity.y) == y_dir:
#		velocity.y = move_toward(velocity.y, y_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta)
#	else:
#		velocity.y = move_toward(velocity.y, y_dir * MAX_SPEED * FACTOR , ACCEL * FACTOR * delta)
#	if (abs(velocity.x) >= MAX_SPEED * FACTOR and abs(velocity.y) >= MAX_SPEED * FACTOR ) and (sign(velocity.x) == x_dir and sign(velocity.y) == y_dir):
#		velocity.x = move_toward(velocity.x, x_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta) / 2
#		velocity.y = move_toward(velocity.y, y_dir * MAX_SPEED * FACTOR, FRICTION * FACTOR * delta) / 2

	#NUMBER TWO
	if velocity.abs() >= Vector2(1,1):
		velocity = velocity.move_toward(dir, FRICTION * FACTOR)
	else:
		velocity = velocity.move_toward(dir, ACCEL * FACTOR)




