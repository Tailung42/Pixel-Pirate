extends CharacterBody2D

#constants
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
# variables
var direction = 1
var is_running = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_running and not ($RayCastLeft.is_colliding() or $RayCastRight.is_colliding()):
		start_running()

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Handle jump.
	if $RayCastUp.is_colliding() and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# handles wall collision
	if $RayCastRight.is_colliding() and is_running:
		stop_running()
		$RayCastRight.enabled = false
		# await get_tree().create_timer(1.0).timeout
		change_direction()
		$RayCastLeft.enabled = true
		start_running()

	if $RayCastLeft.is_colliding() and is_running:
		stop_running()
		$RayCastLeft.enabled = false 
		# await get_tree().create_timer(1.0).timeout 
		change_direction()
		$RayCastRight.enabled = true
		start_running()

	move_and_slide()


func stop_running():
	is_running = false
	velocity.x = 0


func change_direction():
	direction = -direction


func start_running():
	is_running = true
	velocity.x = direction * SPEED