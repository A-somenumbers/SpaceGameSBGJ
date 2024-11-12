extends CharacterBody2D

@export var movement_speed : float = 500

@onready var projectileO = preload("res://scenes/projectiles/projectile_1.tscn")

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
	if body.has_method("hp"):
		health += 20
		print(health)
	if body.has_method("doubleDmg"):
		Global.damage = Global.damage*2


func _on_player_hbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attackRange = false
		
func enemy_attack():
	if enemy_attackRange and attack_cooldown:
		health = health - 20
		attack_cooldown = false
		$attack_cooldown.start()
		print("player took damage, now at: ")
		print(health)
	
func player():
	pass
func playerMovementandInput():
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	if character_direction.x > 0: $flip.scale.x = 1
	elif character_direction.x < 0: $flip.scale.x = -1
	move_and_slide()
	
	if character_direction: 
		velocity = character_direction * movement_speed
		if Global.player_current_attack == false:
			if $flip/sprite.animation != "walking": $flip/sprite.animation = "walking"
	
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if Global.player_current_attack == false:
			if $flip/sprite.animation != "idle": $flip/sprite.animation = "idle"
	
func attack():
	var dir = character_direction
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		$"flip/sprite".animation = "shoot"
		$"deal attack timer".start()
		var p1 = projectileO.instantiate()
		p1.global_position = $flip/shotPos.global_position
		p1.vel = $flip.scale.x
		get_parent().add_child(p1)
		
	
			
func _on_attack_cooldown_timeout() -> void:
	
	attack_cooldown = true


func _on_deal_attack_timer_timeout() -> void:
	$"deal attack timer".stop()
	Global.player_current_attack = false
