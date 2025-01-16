extends Node2D

signal start
signal game_start_ai
signal game_start_two

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _on_button_ai_pressed() -> void:
	$ButtonAI.hide()
	$ButtonTwo.hide()
	start.emit()
	game_start_ai.emit()

func _on_button_two_pressed() -> void:
	$ButtonAI.hide()
	$ButtonTwo.hide()
	start.emit()
	game_start_two.emit()

func _on_button_restart_pressed() -> void:
	#$GameManager.score_blue = 0
	#$GameManager.score_red = 0
	#$Ball.reset()
	#$Paddle/Paddle_Blue.reset()
	#$Paddle/Paddle_Red.reset()
	pass
