extends CharacterBody2D

@export var movement_speed : float = 500

var character_direction : Vector2
var enemy_attackRange = false
var attack_cooldown = true
var health = 100
var player_alive = true
var attackIp = false
func _physics_process(delta):
	playerMovementandInput()
	if health <= 0:
		player_alive = false
		health = 0;
		print("dead!")
		self.queue_free()
	enemy_attack()
	attack()


func _on_player_hbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attackRange = true


func _on_player_hbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attackRange = false
		
func enemy_attack():
	if enemy_attackRange and attack_cooldown:
		health = health - 20
		attack_cooldown = false
		$attack_cooldown.start()
		print("player took damage")
	
func player():
	pass
func playerMovementandInput():
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	if character_direction.x > 0: %sprite.flip_h = false
	elif character_direction.x < 0: %sprite.flip_h = true
	move_and_slide()
	
	if character_direction: 
		velocity = character_direction * movement_speed
		if attackIp:
			if %sprite.animation != "attack": %sprite.animation = "attack" 
		if %sprite.animation != "walking": %sprite.animation = "walking"
	elif attackIp:
		if %sprite.animation != "attack": %sprite.animation = "attack" 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %sprite.animation != "idle": %sprite.animation = "idle"
	
func attack():
	var dir = character_direction
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attackIp = true
		$"deal attack timer".start()
		
			
func _on_attack_cooldown_timeout() -> void:
	
	attack_cooldown = true


func _on_deal_attack_timer_timeout() -> void:
	$"deal attack timer".stop()
	attackIp = false
