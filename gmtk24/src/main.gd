extends Control

@onready var current_time_label = $UI/CurrentTime
@onready var background = $SubViewportContainer/SubViewport/Background
@onready var skill_tree = $SkillTree
var dept
var diff
var event

const END_GAME_TIME = 1.5768e+17 #5 billion years in seconds

var sim_time : float
var time_skip_amount
var fast_forward_until = 0

var sim_time_scale : int = 1

var start_sim_unix_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_sim_unix_time = Time.get_unix_time_from_system() + Time.get_time_zone_from_system()['bias'] * GV.SEC_IN_MIN
	sim_time = 0
	
	time_skip_amount = GV.SEC_IN_DAY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sim_time - delta * sim_time_scale < END_GAME_TIME:
		sim_time += delta * sim_time_scale
	else:
		sim_time = END_GAME_TIME
		print('YOU WIN')
		sim_time_scale = 0
	
	GV.incease_resources(delta * sim_time_scale)
	background.update_time(start_sim_unix_time + sim_time, delta, sim_time_scale)
	current_time_label.text = "current time: " + GV.display_time_from_seconds(start_sim_unix_time + sim_time)
	
	if fast_forward_until < sim_time:
		sim_time_scale = 1

func _on_fast_forward_pressed() -> void:
	fast_forward_until = sim_time + time_skip_amount
	sim_time_scale = time_skip_amount / 15
	time_skip_amount *= 2
	choose_event()

func choose_event():
	#Choose unoccupied department
	if len(Events.avail_dept) >= 1:
		dept = Events.avail_dept.pick_random()
		diff = Events.CATG.values().pick_random()
		
		event = Events.events_categories[dept][diff].pick_random()
		Events.cur_events.append(event)
		Events.avail_dept.erase(dept)
		print("Event chosen is: ", Events.events_desc[event][0])
