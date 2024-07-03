extends CharacterBody2D
var  max_jumps = 200.0
var jumps

const SPEED = 150.0
const camera_offset_x = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	$AnimatedSprite2D.play()
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps = 0

	# handles jump
	if Input.is_action_just_pressed("move_up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumps += 1
		elif jumps > 0 and jumps < max_jumps:
			velocity.y = JUMP_VELOCITY
			jumps += 1
			
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		
	# Play appropriate animations
	if velocity.length() == 0:
		$AnimatedSprite2D.animation = "idle"
	if velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if velocity.y  < 0:
		$AnimatedSprite2D.animation = "jump"
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "fall"
		
			


	move_and_slide()
