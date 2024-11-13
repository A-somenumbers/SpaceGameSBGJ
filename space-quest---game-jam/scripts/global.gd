extends Node

var player_current_attack = false
var player_health
var score = 0
var base_damage = 20
var damage = 20
var mode = 0
var cooldown = 4.0
var dmg = false

func _physics_process(delta: float) -> void:
	if mode != 0:
		damage = base_damage * 2
		cooldown -= delta
		print(cooldown)
		if cooldown <= 0:
			mode =0
			cooldown = 1
			damage = base_damage
