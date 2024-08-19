extends VBoxContainer
class_name EventReport

@onready var choice_tree = $choice_tree
@onready var countdown = $Countdown

var active_event : ActiveEvent: 
	set(event):
		active_event = event
		$Cur_text.text = Events.events_desc[active_event.type][1]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if active_event:
		var time_remaining = active_event.countdown
		if time_remaining > 0:
			countdown.text = 'Time Remaining: ' + GV.display_countdown(time_remaining)
		else:
			expire(Color(1,0.5,0.5,0.5))
		

func expire(color) -> void:
	self.modulate = color
	choice_tree.visible = false
	
func _on_choice_1_pressed() -> void:
	expire(Color(0.5,0.5,0.5,0.5))
