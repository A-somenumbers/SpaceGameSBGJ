extends Node

var player_current_attack = false
var score = 0
var damage = 50
var mode = 0
var cooldown = 4.0
var dmg = false
func _physics_process(delta: float) -> void:
	#print(score)
	if mode != 0:
		cooldown -= delta
		print(cooldown)
		if cooldown <= 0:
			mode =0
			cooldown = 1
