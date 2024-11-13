extends Control

	
@export var healthLabel : Label
@export var ScoreLabel : Label
func _physics_process(delta: float) -> void:
	update_health()
	update_score()

func update_health():
	healthLabel.text= ": " + str(Global.player_health)

func update_score():
	ScoreLabel.text= "Score: " + str(Global.score)
