extends CharacterBody2D

# constants
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
# variables
var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_execute = true
var is_running = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.length() == 0:
			$AnimatedSprite2D.animation = "idle"
		else:
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.flip_h = direction > 0

	# handle wall collision
	if $RayCastLeft.is_colliding() and is_running:
		# await stop_running($RayCastLeft)
		change_direction()
		await  stop_running($RayCastLeft)
		start_running($RayCastRight)

	if $RayCastRight.is_colliding() and is_running:
		# await stop_running($RayCastRight)
		change_direction()
		await stop_running($RayCastRight)
		start_running($RayCastLeft)

	# Handle jump.
	if $RayCastUp.is_colliding() and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_killzone_body_entered(body:Node2D):
	$AnimatedSprite2D.animation = "attack"


func stop_running(body):
	is_running = false
	# velocity.x = 0
	# disable_raycast(body)
	# $AnimatedSprite2D.play("idle")
	await get_tree().create_timer(1).timeout
	return



func start_running(body):
	is_running = true
	# velocity.x = SPEED * direction
	# enable_raycast(body)
	# $AnimatedSprite2D.play("run")


func change_direction():
	direction = -direction



func disable_raycast(body):
	# $RayCastLeft.collision_mask = 0
	# $RayCastRight.collision_mask = 0
	body.collision_mask = 0

func enable_raycast(body):
	# $RayCastLeft.collision_mask = 2
	# $RayCastRight.collision_mask = 2
	body.collision_mask = 2
