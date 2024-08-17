extends Control

@onready var current_time_label = $UI/CurrentTime

var current_time : float
var time_skip_amount
var fast_forward_until = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_time = 0
	time_skip_amount = 60*60*24

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_time - delta < 1.5768e+17: #billion years in seconds
		current_time += delta
	else:
		current_time = 1.5768e+17
		print('YOU WIN')
		Engine.time_scale = 1
		
	current_time_label.text = "current time: " + GlobalVariables.display_time_from_seconds(current_time)
	
	if fast_forward_until < current_time:
		Engine.time_scale = 1

func _on_fast_forward_pressed() -> void:
	fast_forward_until = current_time + time_skip_amount
	Engine.time_scale = time_skip_amount / 30
	time_skip_amount *= 2
