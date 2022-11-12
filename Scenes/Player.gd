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
var prev_dir = Vector2.ZERO
var dir = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dir != Vector2.ZERO:
		prev_dir = dir
	
	$AnimatedSprite.play()
	
	match state:
		IDLE:
			velocity = Vector2.ZERO
			set_idle_animations()
			
			#change states
			if dir.length() != 0:
				set_state(MOVE)
		DASH:
			set_dash_velocity(dir)
			move_and_slide(velocity * MAX_SPEED * FACTOR)
			set_dash_animations()
			
			$Whoosh.play(0.087)
			
			#change states
			if state_time >= dash_time:
				set_state(MOVE)
		MOVE:
			set_velocity(dir)
			move_and_slide(velocity * MAX_SPEED * FACTOR)
			set_move_animations()
			
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
	if velocity.abs() >= Vector2(1,1):
		velocity = velocity.move_toward(dir, FRICTION * FACTOR)
	else:
		velocity = velocity.move_toward(dir, ACCEL * FACTOR)
		
func set_idle_animations():
	if prev_dir.x > 0:
		$AnimatedSprite.animation = "idle_r"
	elif prev_dir.x < 0:
		$AnimatedSprite.animation = "idle_l"
	elif prev_dir.y > 0:
		$AnimatedSprite.animation = "idle_d"
	elif prev_dir.y < 0:
		$AnimatedSprite.animation = "idle_u"
	elif prev_dir.x == 0 && prev_dir.y == 0:
		$AnimatedSprite.animation = "idle_d"

func set_move_animations():
	if dir.x > 0:
		$AnimatedSprite.animation = "move_r"
	elif dir.x < 0:
		$AnimatedSprite.animation = "move_l"
	elif dir.y > 0:
		$AnimatedSprite.animation = "move_d"
	elif dir.y < 0:
		$AnimatedSprite.animation = "move_u"

func set_dash_animations():
	if dir.x > 0:
		$AnimatedSprite.animation = "dash_r"
	elif dir.x < 0:
		$AnimatedSprite.animation = "dash_l"

func check_collisions():
	pass
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		if collision.coll
