extends Control

@onready var current_time_label = $UI/CurrentTime
@onready var background = $Background

const END_GAME_TIME = 1.5768e+17 #5 billion years in seconds

var current_time : float
var time_skip_amount
var fast_forward_until = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_time = 60*60*12
	time_skip_amount = 60*60*24

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_time - delta < END_GAME_TIME:
		current_time += delta
	else:
		current_time = END_GAME_TIME
		print('YOU WIN')
		Engine.time_scale = 1
	
	background.update_time(current_time, delta)
	current_time_label.text = "current time: " + GlobalVariables.display_time_from_seconds(current_time)
	
	if fast_forward_until < current_time:
		Engine.time_scale = 1

func _on_fast_forward_pressed() -> void:
	fast_forward_until = current_time + time_skip_amount
	Engine.time_scale = time_skip_amount / 15
	time_skip_amount *= 2
