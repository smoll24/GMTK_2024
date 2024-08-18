extends Control

@onready var current_time_label = $UI/CurrentTime
@onready var background = $SubViewportContainer/SubViewport/Background
@onready var skill_tree = $SkillTree

const END_GAME_TIME = 1.5768e+17 #5 billion years in seconds

var sim_time : float
var time_skip_amount
var fast_forward_until = 0

var sim_time_scale : int = 1

var start_sim_unix_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_sim_unix_time = Time.get_unix_time_from_system() + Time.get_time_zone_from_system()['bias'] * 60
	sim_time = 0
	
	time_skip_amount = 60*60*24
	print(Time.get_time_zone_from_system()['bias'] * 60)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sim_time - delta * sim_time_scale < END_GAME_TIME:
		sim_time += delta * sim_time_scale
	else:
		sim_time = END_GAME_TIME
		print('YOU WIN')
		sim_time_scale = 0
	
	background.update_time(start_sim_unix_time + sim_time, delta, sim_time_scale)
	current_time_label.text = "current time: " + GlobalVariables.display_time_from_seconds(start_sim_unix_time + sim_time)
	
	if fast_forward_until < sim_time:
		sim_time_scale = 1

func _on_fast_forward_pressed() -> void:
	fast_forward_until = sim_time + time_skip_amount
	sim_time_scale = time_skip_amount / 15
	time_skip_amount *= 2


		
