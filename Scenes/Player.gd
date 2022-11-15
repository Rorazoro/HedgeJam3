extends KinematicBody2D

class_name Player

enum {
	MOVE,
	IDLE,
	DASH,
}


#set default state
var state = IDLE

# the movement variables (mess around with them to make the movement the way you like)
export (float) var FACTOR = 1.5
export (float) var MAX_SPEED = 100
export (float) var FRICTION = 900 
export (float) var ACCEL = 1000 

var dash_acc = 20
var state_time = 0.0
export (float) var dash_time = 0.15
var prev_dir = Vector2.ZERO
var dir = Vector2.ZERO
var velocity = Vector2.ZERO
var inputEnabled = true

func _physics_process(delta):
	if inputEnabled:
		move(delta)
		interact()
	
func move(delta):
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dir != Vector2.ZERO:
		prev_dir = dir
	
	$AnimatedSprite.play()
	
	match state:
		IDLE:
			velocity = Vector2.ZERO
			set_idle_animations()
			set_raycast_direction()
			
			#change states
			if dir.length() != 0:
				set_state(MOVE)
		DASH:
			set_dash_velocity(dir)
			move_and_slide(velocity * MAX_SPEED * FACTOR)
			set_dash_animations()
			set_raycast_direction()
			
			$Whoosh.play(0.087)
			
			#change states
			if state_time >= dash_time:
				set_state(MOVE)
		MOVE:
			set_velocity(dir)
			move_and_slide(velocity * MAX_SPEED * FACTOR)
			set_move_animations()
			set_raycast_direction()
			
			#change states
			if dir.length() == 0:
				set_state(IDLE)
			elif Input.is_action_just_pressed("dash"):
				set_state(DASH)
#increment time in each state by delta
	state_time += delta

func interact():
	if Input.is_action_just_pressed("interact") and $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider();
		print("Player recognized object (" + collider.name + ")")
		collider.on_interact(self)

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
		
func set_raycast_direction():
	if prev_dir.x > 0:
		$RayCast2D.rotation_degrees = -90
	elif prev_dir.x < 0:
		$RayCast2D.rotation_degrees = 90
	elif prev_dir.y > 0:
		$RayCast2D.rotation_degrees = 0
	elif prev_dir.y < 0:
		$RayCast2D.rotation_degrees = 180
	elif prev_dir.x == 0 && prev_dir.y == 0:
		$RayCast2D.rotation_degrees = 0

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
