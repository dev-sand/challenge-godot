extends CharacterBody2D

# Base speed of the paddle
const SPEED 	= 300

# Determines the direction to move the paddle (Up or Down)
var direction 	= Vector2()

func _ready() -> void:
	hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		move(delta)

func move(delta: float):
	# Determine if an action key has been pressed and set direction accordingly (-1, 0, 1)
	direction.y = -int(Input.is_action_pressed("move_blue_up")) + int(Input.is_action_pressed("move_blue_down"))
	
	# Updating the velocity of the object.
	velocity.y = direction.y * delta * SPEED
	
	# Update the objects position.
	move_and_collide(velocity)

func reset():
	pass
	
func _on_game_start() -> void:
	show()
