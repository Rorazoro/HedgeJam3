extends KinematicBody2D

export(bool) var isReal = false
export(float) var MAX_SPEED = 50
export(float) var AI_START_PERIOD = 2

var startAI = false
var targetPlayer : Node2D
var dir = Vector2.ZERO
var velocity = Vector2.ZERO
var aiStarted = false
var aiStartTime = 0

func _ready():
	add_to_group("phonebooth")

func _physics_process(delta):
	if startAI:
		if !aiStarted:
			aiStartTime += delta
			check_ai_start_time_elapsed()
		else:
			set_target_location(targetPlayer.position)
			move(delta)

func on_interact(player):
	print("Received interact notification")
	if !isReal:
		$Phonebooth.visible = false
		$Phonebooth_Monster.visible = true
		targetPlayer = player
		startAI = true
	else:
		GameManager.on_win()

func set_target_location(target:Vector2):
	$NavigationAgent2D.set_target_location(target)

func check_ai_start_time_elapsed():
	if aiStartTime > AI_START_PERIOD:
		aiStarted = true
		aiStartTime = 0

func move(delta):
	dir = position.direction_to($NavigationAgent2D.get_next_location())
	velocity = dir * MAX_SPEED
	look_at_direction(dir)
	$NavigationAgent2D.set_velocity(velocity)
	#velocity = move_and_slide(velocity)
	var collision  = move_and_collide(velocity * delta)
	if collision and collision.collider.name == "Player":
		GameManager.on_lose()
	
func look_at_direction(direction:Vector2):
	direction = direction.normalized()
	$Phonebooth_Monster.flip_h = direction.x < 0

# extends StaticBody2D

# var interactable = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
	# if interactable:
		# if Input.is_action_just_pressed("interact"):
			# print("Phonebooth checked!")
	# else: 
		# pass


# func _on_Area2D_body_entered(body):
	# if body.name == "Player":
		# interactable = true


# func _on_Area2D_body_exited(body):
	# if body.name == "Player":
		# interactable = false
