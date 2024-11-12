extends CharacterBody2D

var speed = 50
var health = 100


var dead = false
var player_in_range = false
var player
var isattacking = false
func _ready():
	dead = false
func _physics_process(delta: float) -> void:
	if !dead:
		$"detection area/CollisionShape2D".disabled = false
		if player_in_range:
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
	
		
	if dead:
		$"detection area/CollisionShape2D".disabled = true
	if isattacking:
		$AnimatedSprite2D.play("bro fell 💀")
	else: 
		$AnimatedSprite2D.play("Idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print("gloop :P")
		player_in_range = true
		player = body
		
		
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	var damage
	if body.has_method("proj"):
		print("gleep :D")
		body.queue_free()
		damage = Global.damage
		take_damage(damage)
	if body.has_method("player"):
		isattacking = true

func take_damage(damage):
	health -= damage
	if health<= 0 and !dead:
		death()
		
func death():
	dead = true;
	Global.score += 100
	queue_free()
	
#references for other aspects
func enemy():
	pass


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		isattacking = false
