extends Control

var text_toggle

@onready var text_open = $Text_open
@onready var text_close = $Text_close
@onready var officer_sprite = $Text_open/Officer_img
@onready var space_envent_list = $Text_open/SpaceEventsList
@onready var human_envent_list = $Text_open/HumanEventsList
@onready var nature_envent_list = $Text_open/NatureEventsList


@onready var event_report = preload("res://src/events/event_report.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Close text panel
	text_toggle = false
	text_open.visible = false
	text_close.visible = true
	officer_sprite.play()
	
func _process(_delta: float) -> void:
	if Events.cur_dept == Events.DEPT.SPACE:
		officer_sprite.play("Kessler")
	elif Events.cur_dept == Events.DEPT.HUMAN:
		officer_sprite.play("Monroe")
	elif Events.cur_dept == Events.DEPT.NATURE:
		officer_sprite.play("Reyes")

func add_event_report(event : ActiveEvent, dept : Events.DEPT):
	var e : EventReport = event_report.instantiate()
	if dept == Events.DEPT.SPACE:
		e.init_event(event, "Kessler")
		space_envent_list.add_child(e)
	elif dept == Events.DEPT.HUMAN:
		e.init_event(event, "Monroe")
		human_envent_list.add_child(e)
	elif dept == Events.DEPT.NATURE:
		e.init_event(event, "Reyes")
		nature_envent_list.add_child(e)

func _on_close_text_pressed() -> void:
	if text_toggle:
		text_toggle = false
		text_open.visible = false
		text_close.visible = true

func _on_open_text_pressed() -> void:
	if not text_toggle:
		text_toggle = true
		text_open.visible = true
		text_close.visible = false
