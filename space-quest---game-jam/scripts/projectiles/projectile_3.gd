extends CharacterBody2D

var SPEED = 300
var vel: float

func  _physics_process(delta):
	move_local_x(vel*SPEED*delta)
	move_local_y(vel*SPEED*delta)
	
func proj():
	pass
	


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
