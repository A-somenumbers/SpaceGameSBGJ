extends Control

	
@export var healthLabel : Label
@export var ScoreLabel : Label
@export var TimeLabel : Label
func _physics_process(delta: float) -> void:
	
	update_score()
	

func update_health():
	healthLabel.text= ": " + str(Global.player_health)

func update_score():
	ScoreLabel.text= "Score: " + str(Global.score)
	
func time():
	var temp_text = "Time Left %d"
	TimeLabel.text = temp_text % [int(Global.time)]
	
