extends Control

@onready var current_time_label = $UI/CurrentTime
@onready var background = $SubViewportContainer/SubViewport/Background
@onready var skill_tree = $SkillTree
@onready var event_report_ui = $UI/ui_viewport
@onready var notification_tree = $UI/notification_tree
@onready var event_popup = preload("res://src/events/event_notif.tscn")

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
	if sim_time - delta * sim_time_scale < GV.END_GAME_TIME:
		sim_time += delta * sim_time_scale
	else:
		sim_time = GV.END_GAME_TIME
		print('YOU WIN')
		sim_time_scale = 0
	
	GV.incease_resources(delta * sim_time_scale)
	Events.reduce_countdown(delta * sim_time_scale)
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
		var dept = Events.avail_dept.pick_random()
		var diff = Events.CATG.values().pick_random()
		var event = Events.events_categories[dept][diff].pick_random()
		
		var active_event = ActiveEvent.new(event, dept, GV.SEC_IN_DAY*7)
		
		Events.cur_events.append(active_event)
		Events.avail_dept.erase(dept)
		print("Event chosen is: ", Events.events_desc[event][0])
		
		event_report_ui.add_event_report(active_event)
		
		var event_notif = event_popup.instantiate()
		notification_tree.add_child(event_notif)
		event_notif.popup(active_event, diff)
