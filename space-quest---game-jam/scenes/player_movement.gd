extends CharacterBody2D

var movement_speed : float = 200	# Base movement speed.
var dash_speed : float = 600				# How fast the player dashes.
var can_dash = true							# Whether if the player can dash or not.
@export var max_health: int = 3				# The maximum health of the player.
@export var health : int = 1				# How many hearts the player has (most enemies do 1 heart damage?)

var character_direction : Vector2			# Directional movement for the player.

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
		if Input.is_action_pressed("dash") and can_dash:
			dash()
	
	# Else, player not moving; play the idle animation.
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %sprite.animation != "idle": %sprite.animation = "idle"
	print(velocity)
	move_and_slide()
	
	# Check if the player is colliding with a powerup.
	# for p in get_parent().get_node("powerups").get_children():
	#	p.connect("player_collision", self.powerup_logic)

# Set can dash to false and start dashing timer.
func dash():
	velocity = character_direction.normalized() * dash_speed
	if $dash_alarm.is_stopped():
		$dash_alarm.start()

# Dashing timer ends out = dash ends.
func _on_dash_alarm_timeout():
	can_dash = false
	movement_speed = 200
	$dashing_cooldown.start()

# Dashing cooldown ends = can_dash back to true.
func _on_dashing_cooldown_timeout():
	can_dash = true

# Powerup logic.
func powerup_logic(powerup_type):
	match powerup_type:
		0:
			# Only heal if health is less than the maximum health.
			if health < max_health:
				health += 1
			print(health)

# Taking damage from an enemy logic.
func enemy_logic(enemy_type):
	match enemy_type:
		0:
			health -= 1
		1:
			health -=1
		2:
			health -=1
