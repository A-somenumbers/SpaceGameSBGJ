extends CharacterBody2D

@export var movement_speed : float = 200
var dash_speed : float = 600
var can_dash = true

@onready var projectileO = preload("res://scenes/projectiles/projectile_1.tscn")
@onready var projectile1 = preload("res://scenes/projectiles/projectile_2.tscn")
@onready var projectile2 = preload("res://scenes/projectiles/projectile_3.tscn")
var dmgGiven = 10

var character_direction : Vector2
var enemy_attackRange = false
var attack_cooldown = true
var health = 100
var player_alive = true
var attackIp = false
func _physics_process(delta):
	playerMovementandInput()
	Global.player_health = health
	if health <= 0:
		player_alive = false
		health = 0;
		self.queue_free()
	enemy_attack()
	attack()
	
	
	


func _on_player_hbox_body_entered(body: Node2D) -> void:
	if body.has_method("alienG"):
		enemy_attackRange = true
		dmgGiven = 10
	if body.has_method("alienP"):
		enemy_attackRange = true
		dmgGiven = 20
	if body.has_method("hp"):
		health += 20
	if body.has_method("doubleDmg"):
		Global.damage = Global.damage*2


func _on_player_hbox_body_exited(body: Node2D) -> void:
	if body.has_method("alienG"):
		enemy_attackRange = false
	if body.has_method("alienP"):
		enemy_attackRange = false	
func enemy_attack():
	if enemy_attackRange and attack_cooldown:
		health = health - dmgGiven
		attack_cooldown = false
		$attack_cooldown.start()
	
func player():
	pass
func playerMovementandInput():
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	if character_direction.x > 0: $flip.scale.x = 1
	elif character_direction.x < 0: $flip.scale.x = -1
	move_and_slide()
	
	if character_direction: 
		velocity = character_direction.normalized() * movement_speed
		if Input.is_action_pressed("dash") and can_dash:
			dash()
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
		
		if(Global.mode == 1):
			
			var p1 = projectileO.instantiate()
			p1.global_position = $flip/shotPos.global_position
			p1.vel = $flip.scale.x
			get_parent().add_child(p1)
			var p2 = projectile1.instantiate()
			var p3 = projectile2.instantiate()
			p2.global_position = $flip/shotPos.global_position
			p2.vel = $flip.scale.x
			get_parent().add_child(p2)
			p3.global_position = $flip/shotPos.global_position
			p3.vel = $flip.scale.x
			get_parent().add_child(p3)
		elif (Global.mode == 0):
			var p1 = projectileO.instantiate()
			p1.global_position = $flip/shotPos.global_position
			p1.vel = $flip.scale.x
			get_parent().add_child(p1)
	
			
func _on_attack_cooldown_timeout() -> void:
	
	attack_cooldown = true


func _on_deal_attack_timer_timeout() -> void:
	$"deal attack timer".stop()
	Global.player_current_attack = false

#evan's dash code
func dash():
	velocity = character_direction.normalized() * dash_speed
	if $DashAlarm.is_stopped():
		$DashAlarm.start()
	


func _on_dash_alarm_timeout() -> void:
	can_dash = false
	movement_speed = 200
	$DashCool.start()


func _on_dash_cool_timeout() -> void:
	can_dash = true
