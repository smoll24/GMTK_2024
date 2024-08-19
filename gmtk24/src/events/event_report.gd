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
		countdown.text = 'Time left: ' + GV.display_time_from_seconds(active_event.countdown, true)

func expire() -> void:
	self.modulate = Color(0.5,0.5,0.5,0.5)
	choice_tree.visible = false
	
func _on_choice_1_pressed() -> void:
	expire()
