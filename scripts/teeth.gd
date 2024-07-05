extends CharacterBody2D

#constants
const SPEED = 170.0
const JUMP_VELOCITY = -420.0
# variables
var direction = 1
var is_running = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
		$RayCastUp.enabled = false
		stop_running()
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")


	# # handles player detection
	if $RayCastRight.is_colliding() and is_on_floor():
		$RayCastRight.enabled = false
		$RayCastLeft.enabled = true
		change_direction(1)
		start_running()

	if $RayCastLeft.is_colliding() and is_on_floor():
		$RayCastRight.enabled = true
		$RayCastLeft.enabled = false

		change_direction(-1)
		start_running()

	move_and_slide()


func stop_running():
	is_running = false
	velocity.x = 0
	if is_on_floor():
		$AnimatedSprite2D.play("idle")


func change_direction(string):
	if string == 0:
		direction = -direction

	else:
		if string == -1:
			direction = -1
		elif string == 1:
			direction = 1
	$AnimatedSprite2D.flip_h = direction > 0


func start_running():
	is_running = true
	velocity.x = direction * SPEED
	$AnimatedSprite2D.play("run")


func _on_killzone_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("attack")
		# if is_on_floor():
		# 	await get_tree().create_timer(1).timeout
		# 	start_running()
	else:
		stop_running()
		change_direction(0)
		start_running()

func _on_killzone_body_exited(body:Node2D):
	if is_on_floor():
		get_tree().create_timer(0.5).timeout
		start_running()
		$RayCastUp.enabled = true
