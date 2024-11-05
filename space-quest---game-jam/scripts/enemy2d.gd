extends CharacterBody2D

var speed = 25
var player_chase = false 
var player = null

var health = 100
var player_inAttackRange = false


func _physics_process(delta):
	deals_with_damage()
	if player_chase:
		position += (player.position - position)/speed
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
func enemy():
	pass	


func _on_enemy_hbox_area_shape_entered(body):
	if body.has_method("player"):
		player_inAttackRange = true


func _on_enemy_hbox_area_shape_exited(body):
	if body.has_method("player"):
		player_inAttackRange = false

func deals_with_damage():
	if player_inAttackRange and Global.player_current_attack:
		health = health - 50
		print(health)
		if(health<=0):
			self.queue_free()
