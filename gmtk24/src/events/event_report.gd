extends VBoxContainer
class_name EventReport

@onready var choice_tree = $choice_tree
@onready var time_tree = $time_tree
@onready var countdown = $time_tree/Countdown

var choice1_bool = true
var choice2_bool = true

var active_event : ActiveEvent
		
func _process(delta: float) -> void:
	if choice1_bool == false:
		$choice_tree/Choice1.self_modulate = Color(1,1,1,0.5)
	if choice2_bool == false:
		$choice_tree/Choice2.self_modulate = Color(1,1,1,0.5)
	
	if active_event != null:
		var time_remaining = active_event.countdown
		if time_remaining > 0:
			countdown.text = 'Time Remaining: ' + GV.display_countdown(time_remaining)
		else:
			expire(Color(1,0.5,0.5,0.5), 3)

func expire(color, outcome) -> void:
	self.modulate = color
	choice_tree.visible = false
	time_tree.visible = false
	active_event.expire(outcome)

func init_event(event : ActiveEvent, officer_name : String):
	active_event = event
	$Cur_text.text = Events.events_desc[active_event.type][1]
	$choice_tree/Choice1.text = Events.events_desc[active_event.type][2]
	$choice_tree/Choice2.text = Events.events_desc[active_event.type][3]
	$Cur_speaker.text = officer_name


func _on_choice_1_mouse_entered() -> void:
	if choice1_bool:
		$choice_tree/Choice1.self_modulate = Color(1.5,1.5,1.5,1.5)
func _on_choice_1_mouse_exited() -> void:
	$choice_tree/Choice1.self_modulate = Color(1,1,1,1)
func _on_choice_2_mouse_entered() -> void:
	if choice2_bool:
		$choice_tree/Choice2.self_modulate = Color(1.5,1.5,1.5,1.5)
func _on_choice_2_mouse_exited() -> void:
	$choice_tree/Choice2.self_modulate = Color(1,1,1,1)


func _on_choice_1_meta_clicked(_meta: Variant) -> void:
	if choice1_bool:
		print("Choice 1")
		expire(Color(0.5,0.5,0.5,0.5), 0)


func _on_choice_2_meta_clicked(_meta: Variant) -> void:
	if choice2_bool:
		print("Choice 2")
		expire(Color(0.5,0.5,0.5,0.5), 2)
