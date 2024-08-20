extends Node
class_name ActiveEvent

var type : Events.EVENT
var dept : Events.DEPT
var countdown : float

signal event_expire(event_type : Events.EVENT)

func _init(event : Events.EVENT, deptartement : Events.DEPT, start_time : float) -> void:
	type = event
	dept = deptartement
	countdown = start_time

func reduce_countdown(delta : float) -> void:
	countdown -= delta

func expire(outcome) -> void:
	emit_signal("event_expire", type, outcome)
	
	Events.avail_dept.append(dept)
	Events.cur_events.erase(self)
	self.queue_free()
	
