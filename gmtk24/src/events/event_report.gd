extends VBoxContainer
class_name EventReport

@onready var choice_tree = $choice_tree
@onready var time_tree = $time_tree
@onready var countdown = $time_tree/Countdown

@onready var choice1 = $choice_tree/Choice1
@onready var choice2 = $choice_tree/Choice2

@onready var officer_name = $Cur_speaker

var active_event : ActiveEvent: 
	set(event):
		active_event = event
		$Cur_text.text = Events.events_desc[active_event.type][1]
		choice1.text = Events.events_desc[active_event.type][2]
		choice2.text = Events.events_desc[active_event.type][3]
		if Events.cur_dept == Events.DEPT.SPACE:
			officer_name.text = "Offcier Kessler"
		elif Events.cur_dept == Events.DEPT.HUMAN:
			officer_name.text = "Offcier Monroe"
		elif Events.cur_dept == Events.DEPT.NATURE:
			officer_name.text = "Offcier Reyes"
			
func _process(delta: float) -> void:
	if active_event != null:
		var time_remaining = active_event.countdown
		if time_remaining > 0:
			countdown.text = 'Time Remaining: ' + GV.display_countdown(time_remaining)
		else:
			expire(Color(1,0.5,0.5,0.5))

func expire(color) -> void:
	self.modulate = color
	choice_tree.visible = false
	time_tree.visible = false
	active_event.expire()
	
func _on_choice_1_pressed() -> void:
	expire(Color(0.5,0.5,0.5,0.5))
