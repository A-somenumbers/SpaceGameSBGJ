extends Node

var player_current_attack = false
var player_health = 100
var score = 0
var base_damage = 20
var damage = 20
var mode = 0
var cooldown = 4.0
var dmg = false
var time = 60.0

func _physics_process(delta: float) -> void:
	time -= delta
	if mode != 0:
		damage = base_damage * 2
		cooldown -= delta
		print(cooldown)
		if cooldown <= 0:
			mode =0
			cooldown = 1
			damage = base_damage
	if time<0:
		get_tree().change_scene_to_file("res://scenes/UI/gameEnd.tscn")
