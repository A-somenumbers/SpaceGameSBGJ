# Evan Stark - November 5th 2024
# Powerup logic - use an enum to store all powerups and assign approriate sprite/effect.
extends Area2D

# New signal that determines if player touches powerup.
signal player_collision
# Powerup types enum; initially a healing powerup.
enum {HEALING}
@export var powerup_type: int = HEALING

# Ready function to assign correct sprite.
func _ready():
	match powerup_type:
		HEALING:
			$sprite.texture = load("res://assets/sprites/coin.png")


# Delete the powerup once player touches it.
func _on_powerup_body_entered(body):
	# Checking if body is the player.
	if body.name == "player":
		emit_signal("player_collision", powerup_type)
		queue_free()
