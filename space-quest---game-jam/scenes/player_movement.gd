extends CharacterBody2D

@export var movement_speed : float = 200	# Base movement speed.
var dash_speed : float = 600				# How fast the player dashes.
var can_dash = true

var character_direction : Vector2

func _physics_process(delta):
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	if character_direction.x > 0: %sprite.flip_h = false
	elif character_direction.x < 0: %sprite.flip_h = true

	if character_direction: 
		# Normalize character direction to keep speed the same for diagonal movement.
		velocity = character_direction.normalized() * movement_speed
		if %sprite.animation != "walking": %sprite.animation = "walking"
	
		# Dashing function; run ONLY if player already moving.
		elif Input.is_action_pressed("dash") and can_dash:
			dash()
	
	# Else, player not moving; play the idle animation.
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %sprite.animation != "idle": %sprite.animation = "idle"
	print(velocity)
	move_and_slide()

# Set can dash to false and start dashing timer.
func dash():
	# Dashing logic.
	$dash_alarm.start()
	velocity = character_direction.normalized() * dash_speed
	print("dashing...")			#DEBUG, delete later!

# Dashing timer ends out = dash ends.
func _on_dash_alarm_timeout():
	can_dash = false
	movement_speed = 200
	$dashing_cooldown.start()

# Dashing cooldown ends = can_dash back to true.
func _on_dashing_cooldown_timeout():
	can_dash = true
	print("Can dash: ")
	print(can_dash)
