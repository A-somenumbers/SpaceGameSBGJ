extends CharacterBody2D



func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.score +=50
		self.queue_free()

func hp():
	pass
	
	
