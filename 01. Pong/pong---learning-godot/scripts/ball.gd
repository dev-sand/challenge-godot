extends Area2D

const SPEED			= 300.0
const TIME			= 2.0

var direction		= Vector2()
var new_dir			= Vector2()
var velocity		= Vector2()
var is_active		= false

@onready var game_manager: Node = %GameManager
@onready var ball_timer: Timer = $BallTimer
@onready var bounce: AudioStreamPlayer = $BallBounce

func _ready() -> void:
	hide()
	
	# New direction start of game
	var dir_x = randi() % 2
	var dir_y = randi() % 2
	
	if dir_x == 0:
		dir_x = -1
		
	if dir_y == 0:
		dir_y = -1
		
	new_dir =  Vector2(dir_x, dir_y)
	
func _process(delta: float) -> void:
	move(delta)

func start():
	ball_timer.start(TIME)

func move(delta: float):
	# Calculate the velocity
	velocity = direction * delta * SPEED
	
	position += velocity
	
func _on_body_entered(body: Node2D) -> void:
	# Change the direction when contact is made with the paddle
	if body.get_parent().name == "Paddle":
		direction.x *= -1
		#print("bounce")
	
	# Change the direction when contact is made with the wall.
	if body.get_parent().name == "Wall":
		direction.y *= -1
		#print("bounce")
	bounce.play()

func _on_scorezone_red_area_entered(area: Area2D) -> void:
	# Increment the Red's score
	game_manager.add_score_red()
	#print("Red: " + str(game_manager.score_red))
		
	# Reset position
	position = get_viewport().size / 2
	direction = Vector2()
		
	# CHange direction to red
	var dir_y = randi() % 2
	
	if dir_y == 0:
		dir_y = -1
	
	# New direction for the ball
	new_dir = Vector2(1, dir_y)
		
	# Start Ball Timer
	ball_timer.start(TIME)
	
	bounce.pitch_scale = 2
	bounce.play()
	bounce.pitch_scale = 0.8


func _on_scorezone_blue_area_entered(area: Area2D) -> void:
	# Increment Blue's score
	game_manager.add_score_blue()
	#print("Blue: " + str(game_manager.score_blue))
	
	# Reset position
	position = get_viewport().size / 2
	direction = Vector2()
		
	# Change direction to blue
	var dir_y = randi() % 2
	
	if dir_y == 0:
		dir_y = -1
	
	# New direction for the ball
	new_dir = Vector2(-1, dir_y)
	
	# Start the ball reset timer
	ball_timer.start(TIME)
	
	bounce.pitch_scale = 2
	bounce.play()
	bounce.pitch_scale = 0.8

func _on_ball_timer_timeout() -> void:
	# Provide a new direction for the ball
	direction = new_dir
	
	# Stop the ball reset timer
	ball_timer.stop()

func reset():
	pass
	
func _on_game_start() -> void:
	show()
	ball_timer.start(TIME)
