extends CharacterBody2D

#constants
const SPEED = 200.0
const JUMP_VELOCITY = -420.0
# variables
var direction = 1
var is_running = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var iswaiting = false

func _physics_process(delta):

	if not is_running and is_on_floor():
		start_running()

	# Add the gravity.s
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Handle jump.
	if $RayCastUp.is_colliding() and is_on_floor():
		stop_running()
		velocity.y = JUMP_VELOCITY


	# handles wall collision
	if $RayCastRight.is_colliding() and is_running:
		stop_running()
		$RayCastRight.enabled = false
		change_direction()
		$RayCastLeft.enabled = true
		start_running()

	if $RayCastLeft.is_colliding() and is_running:
		stop_running()
		$RayCastLeft.enabled = false 
		change_direction()
		$RayCastRight.enabled = true
		start_running()

		# handle appropriate animation
	if is_on_floor():
		if velocity.length() == 0:
			$AnimatedSprite2D.play("idle")
		else:   # if velocity is not 0
			$AnimatedSprite2D.play("run")
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("fall")



	move_and_slide()


func stop_running():
	is_running = false
	velocity.x = 0


func change_direction():
	direction = -direction
	$AnimatedSprite2D.flip_h = direction > 0

func start_running():
	is_running = true
	velocity.x = direction * SPEED