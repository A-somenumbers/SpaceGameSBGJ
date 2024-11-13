# Evan Stark - November 12th 2024
# Moving to level 2.
extends Area2D

@export var next_scene = "res://level_2.tscn"

# Only move if player enters the hitbox.
func _on_body_entered(body):
	# If the player enters the door, change the scene to the next level.
	if body.name.match("player"):
		get_tree().change_scene_to_file(next_scene)
