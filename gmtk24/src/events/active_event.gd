extends Node
class_name ActiveEvent

var type : Events.EVENT
var countdown : float

func _init(event : Events.EVENT, start_time : float) -> void:
	type = event
	countdown = start_time

func reduce_countdown(delta : float) -> void:
	countdown -= delta
