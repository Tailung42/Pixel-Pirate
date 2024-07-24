extends CharacterBody2D
# var
var  max_jumps = 2
var jumps = 0
var life = 3
@onready var control = false

# constants
const SPEED = 150.0
const MAX_LIFE = 3
const camera_offset_x = 200.0
const JUMP_VELOCITY = -400.0
# signals
signal dead
signal damaged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if control:
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
				$sound/jump.play()
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
			$sound/run.stop()
		if velocity.x != 0 and velocity.y == 0:
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		if velocity.y  < 0:
			$AnimatedSprite2D.animation = "jump"
		if velocity.y > 0:
			$AnimatedSprite2D.animation = "fall"
			
				

		# if life == 0:
		# 	# $CollisionShape2D.disabled = true
		# 	# $sound/dead.play()
		# 	# print("dead sent")
		# 	# dead.emit()

		move_and_slide()
		

func _on_player_damaged():
	print("player receives damage")
	if life > 0:
		life -= 1
		if life > 0:
			$sound/damaged.play()
			damaged.emit()
		else:
			$CollisionShape2D.disabled = true
			$sound/dead.play()
			print("dead sent")
			damaged.emit()
			dead.emit()

	


func new_game():
	self.show()
	$CollisionShape2D.disabled = false
	self.life = 3
	self.control = true