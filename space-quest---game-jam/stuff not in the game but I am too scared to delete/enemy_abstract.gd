# Evan Stark - November 7th 2024
# Abstract enemy object that is assigned one of the three enemy types.
extends Area2D

@export var cycle_number: int = 1	# Track which cycle of levels the player is on.
signal player_collision				# Goes off when player collides with it.
enum {FODDER, MID, HARD}			# The three types of enemies to randomly generate.
@export var enemy_type: int = FODDER	# Decides which enemy will be spawned.


# Assign the new enemy to one of the three enemies.
# TODO: variables that make each enemy unique.
func _ready():
	match enemy_type:
		FODDER:
			$sprite.texture = load("res://assets/sprites/slime_green.png")
		MID:
			$sprite.texture = load("res://assets/sprites/slime_purple.png")
		HARD:
			$sprite.texture = load("res://icon.svg")

# Player takes damage when they directly touch enemy.
func _on_enemy_body_entered(body):
	if body.name == "player":
		emit_signal("player_collision", enemy_type)
