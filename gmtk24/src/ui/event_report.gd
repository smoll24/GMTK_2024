extends VBoxContainer
class_name EventReport

var event_type : Events.EVENT: 
	set(event):
		event_type = event
		$Cur_text.text = Events.events_desc[event][1]

func _ready() -> void:
	pass

func init_event(event : Events.EVENT) -> void:
	event_type = event

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
