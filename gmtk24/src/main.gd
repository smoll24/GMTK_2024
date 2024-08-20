extends Control

@onready var current_time_label = $UI/CurrentTime
@onready var time_scale_label = $UI/TimeScale
@onready var background = $SubViewportContainer/SubViewport/Background
@onready var skill_tree = $SkillTree
@onready var event_report_ui = $UI/ui_viewport
@onready var notification_tree = $UI/notification_tree
@onready var city_name_label = $UI/CityName
@onready var event_popup = preload("res://src/events/event_notif.tscn")

var sim_time : float
var time_skip_amount
var fast_forward_until = 0
var next_event_until = GV.SEC_IN_DAY*2

var sim_time_scale : int = 1
var target_sim_speed : int = 1
var cryo_timer = 0
var fast_forward_upgrade_multiplier = 1

var start_sim_unix_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_sim_unix_time = Time.get_unix_time_from_system() + Time.get_time_zone_from_system()['bias'] * GV.SEC_IN_MIN
	sim_time = 0
	
	time_skip_amount = GV.SEC_IN_DAY
	
	city_name_label.text = GV.CityName
	
	GV.game_over.connect(game_over_screen)
	$UI/Cryo_frame.visible = false
	skill_tree.fast_forward_upgrade.connect(upgrade_fast_forward)
	skill_tree.buy_cryo_freeze.connect(unlock_cryo)

func upgrade_fast_forward() -> void:
	fast_forward_upgrade_multiplier += 10

func unlock_cryo() -> void:
	$UI/Cryo_frame.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sim_time - delta * sim_time_scale < GV.END_GAME_TIME:
		sim_time += delta * sim_time_scale
	else:
		sim_time = GV.END_GAME_TIME
		print('YOU WIN')
		target_sim_speed = 0
		sim_time_scale = 0
		$UI_Top/Pop_up_box.visible = true
		$UI_Top/Pop_up_box/Win_screen.visible = true
	
	GV.incease_resources(delta * sim_time_scale)
	Events.reduce_countdown(delta * sim_time_scale)
	background.update_time(start_sim_unix_time + sim_time, delta, sim_time_scale)
	current_time_label.text = "current time: " + GV.display_time_from_seconds(start_sim_unix_time + sim_time)
	time_scale_label.text = "Time Scale: %s/s" % GV.display_magnitude(sim_time_scale)
	
	sim_time_scale = int(lerp(float(sim_time_scale),float(target_sim_speed), delta))
	
	#if fast_forward_until < sim_time:
	#	slow_down()
	#	fast_forward_until = sim_time + time_skip_amount/2
	if next_event_until < sim_time:
		choose_event()
		next_event_until = sim_time + GV.SEC_IN_DAY + (sim_time/10) * (randf_range(0.0, 2.0) ** 2)
		#print(GV.display_countdown(next_event_until - sim_time))

var last_event_time = 0

func game_over_screen():
	target_sim_speed = 0
	sim_time_scale = 0
	$UI_Top/Pop_up_box.visible = true
	$UI_Top/Pop_up_box/Lose_screen.visible = true
	$UI_Top/ui_top_viewport._on_open_text_pressed()

func choose_event():
	#Choose unoccupied department
	var time_since_last_event = last_event_time - sim_time
	
	if len(Events.avail_dept) >= 1:
		var dept = Events.avail_dept.pick_random()
		
		#var randi = randi_range(0,)
		var diff = Events.CATG.values().pick_random()
		var event = Events.events_categories[dept][diff].pick_random()
		
		var event_countdown
		match diff as Events.CATG:
			Events.CATG.SMALL: event_countdown = GV.SEC_IN_DAY * 7
			Events.CATG.MEDIUM: event_countdown = GV.SEC_IN_DAY*7*60
			Events.CATG.LARGE: event_countdown = GV.SEC_IN_YEAR * 4
		
		var active_event = ActiveEvent.new(event, dept, event_countdown)
		active_event.event_expire.connect(event_effect)
		
		Events.cur_events.append(active_event)
		Events.avail_dept.erase(dept)
		print("Event chosen is: ", Events.events_desc[event][0])
		event_report_ui.add_event_report(active_event, dept, sim_time)
		
		var event_notif = event_popup.instantiate()
		notification_tree.add_child(event_notif)
		event_notif.popup(active_event, diff)


func slow_down():
	target_sim_speed = max(1, target_sim_speed/10)

func speed_up(speed, length):
	#if fast_forward_until > sim_time:
	#	fast_forward_until += length
	#else:
	#	fast_forward_until = sim_time + length
	target_sim_speed = speed

func _on_slow_down_pressed() -> void:
	Click.play()
	slow_down()

func _on_forward_pressed() -> void:
	Click.play()
	time_skip_amount = max(GV.SEC_IN_DAY, sim_time)
	speed_up(sim_time_scale + (GV.SEC_IN_DAY / 2) * fast_forward_upgrade_multiplier, time_skip_amount)

func _on_fast_forward_pressed() -> void:
	Click.play()
	time_skip_amount = max(GV.SEC_IN_DAY, sim_time)
	speed_up(sim_time_scale + (GV.SEC_IN_DAY * 31.2) * fast_forward_upgrade_multiplier, time_skip_amount)

func _on_cryo_freeze_pressed() -> void:
	Click.play()
	speed_up(sim_time_scale + max(GV.SEC_IN_YEAR * 5_000, sim_time), time_skip_amount)
	cryo_timer = GV.SEC_IN_YEAR * 5_000
	$Cryo_effect.visible = true

func end_cryo_freeze() -> void:
	$Cryo_effect.visible = false
	target_sim_speed = 1

func event_effect(event_type : Events.EVENT, outcome) -> void:
	match event_type as Events.EVENT:
		Events.EVENT.SAT_COL: GV.res_dict[GV.RES.COMMS]['amount'] -= 10
		Events.EVENT.MIN_AST: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.SOL_FLAR: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.LARG_AST: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.SOL_STORM: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.SPACE_DEBRIS: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.SUN_DEATH: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.ALIENS: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.ROGUE_PLANET: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.BLACK_HOLE: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		
		Events.EVENT.CIV_UNREST: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.CYBERATTACK: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.ECON_DOWN: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.HAPPY_DECILNE: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.PROTESTS: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.RECESSION: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.CULT: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.NUCLEAR_WAR: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.PANDEMIC: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.ECON_COLLAPSE: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.REVOLUTION: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		
		Events.EVENT.RAIN: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.THUNDER: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.EARTHQUAKE: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.DROUGHT: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.FLOOD: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.TORNADO: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.VOLCANO: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.CLIMATE_SHIFT: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10
		Events.EVENT.ECOSYS_COLLAPSE: GV.res_dict[GV.RES.PEOPLE]['amount'] -= 10


func _on_restart_button_pressed() -> void:
	Click.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/title_screen.tscn")


func _on_skill_tree_toggle_pressed() -> void:
	Click.play()
	skill_tree.visible = not skill_tree.visible
