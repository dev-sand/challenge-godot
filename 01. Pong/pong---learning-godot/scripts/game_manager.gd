extends Node

var score_red 	= 0
var score_blue 	= 0

@onready var lb_score_blue: Label = $Score_Blue
@onready var lb_score_red: Label = $Score_Red

func _ready() -> void:
	lb_score_blue.hide()
	lb_score_red.hide()
	
	# Positioning Blue Score
	lb_score_blue.position.x = get_viewport().size.x * 0.2
	lb_score_blue.position.y = get_viewport().size.y * 0.05
	
	#Positioning Red Score
	lb_score_red.position.x = get_viewport().size.x * 0.6
	lb_score_red.position.y = get_viewport().size.y * 0.05

# Used to increase the score value of red
func add_score_red():
	score_red += 1
	lb_score_red.text = str(score_red)
	
# Used to increase the score value of blue
func add_score_blue():
	score_blue += 1
	lb_score_blue.text = str(score_blue)

func _on_game_start() -> void:
	lb_score_blue.show()
	lb_score_red.show()
