extends CharacterBody2D

# Base speed of the paddle
const SPEED 	= 300

# Paddle States
enum {PADDLE_AI, PADDLE_PLAYER, PADDLE_UNKNOWN}

# Paddle State
var paddle_state = PADDLE_UNKNOWN

# Determines the direction to move the paddle (Up or Down)
var direction 	= Vector2()
#var velocity	= Vector2()

# Ball object for tracking with AI
@onready var game_manager: Node = %GameManager
@onready var ball: Area2D = %Ball
@onready var paddle_dir_timer: Timer = $PaddleDirTimer

func _ready() -> void:
	hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match paddle_state:
		PADDLE_AI:
			process_ai(delta)
		PADDLE_PLAYER:
			process_player(delta)
		PADDLE_UNKNOWN:
			pass

func process_ai(delta: float):
	# Follow the balls y-axis
	var track_pos = ball.position
	var track_dir = ball.direction
	var window_width = get_viewport().size.x
	
	if track_dir.x == 1 and track_pos.x > window_width * 0.5:
		if paddle_dir_timer.is_stopped():
			paddle_dir_timer.start(0.25)
	else:
		direction.y = 0
		
	# Updating the velocity of the object.
	velocity.y = direction.y * delta * SPEED
		
	move_and_collide(velocity)

func process_player(delta: float):
	# Determine if an action key has been pressed and set direction accordingly (-1, 0, 1)
	direction.y = -int(Input.is_action_pressed("move_red_up")) + int(Input.is_action_pressed("move_red_down"))
	
	# Updating the velocity of the object.
	velocity.y = direction.y * delta * SPEED
	
	# Update the objects position.
	move_and_collide(velocity)


func _on_paddle_dir_timer_timeout() -> void:
	if ball.position.y > position.y:
		direction.y = 1
	else:
		direction.y = -1
		
	paddle_dir_timer.stop()


func _on_game_game_start_ai() -> void:
	paddle_state = PADDLE_AI
	show()


func _on_game_game_start_two() -> void:
	paddle_state = PADDLE_PLAYER
	show()
