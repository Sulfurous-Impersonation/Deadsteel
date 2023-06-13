extends Sprite2D

@export var car : PathFollow2D # reference to the car coal is currently in

# update coal bool for car on ready
func _ready():
	if car != null:
		car.coal_on_board = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if car != null:
		handle_input()
		update_position()
		if car.player_on_board:
			handle_car_controls()

# switch between train cars on player input
func handle_input():
	if Input.is_action_just_pressed("coal_left"):
		jump_left()
	if Input.is_action_just_pressed("coal_right"):
		jump_right()

# jump one car to the left (toward caboose) if such a car exists
func jump_left():
	if car.next_car != null:
		car.coal_on_board = false
		car = car.next_car
		car.coal_on_board = true

# jump one car to the right (toward engine) if such a car exists
func jump_right():
	if car.prev_car != null:
		car.coal_on_board = false
		car = car.prev_car
		car.coal_on_board = true

# moves coal along with the train
func update_position():
	position = car.position

# automatically control car function
# if booleans are correctly updated (car.coal_on_board), then the car will
# automatically decide what to do when coal is on board, determined in car's
# car_action function
func handle_car_controls():
	car.car_action()
