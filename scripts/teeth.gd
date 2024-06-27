extends CharacterBody2D

# constants
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
# variables
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_execute = true
var is_running = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.length() == 0:
			$AnimatedSprite2D.animation = "idle"
		else:
			$AnimatedSprite2D.animation = "run"

	# handle wall collision
	if colliding_wall():
		await stop_running()
		change_direction()
		enable_raycast()
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = direction > 0

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


func stop_running():
	$AnimatedSprite2D.play("idle")
	disable_raycast()
	is_running = false
	$AnimatedSprite2D.play("idle")
	velocity.x = 0
	await get_tree().create_timer(1).timeout



func start_running():
	pass


func change_direction():
	direction = -direction

func colliding_wall():
	return $RayCastLeft.is_colliding() or $RayCastRight.is_colliding()


func disable_raycast():
	$RayCastLeft.collision_mask = 0
	$RayCastRight.collision_mask = 0

func enable_raycast():
	$RayCastLeft.collision_mask = 2
	$RayCastRight.collision_mask = 2
