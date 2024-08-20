extends Control

var text_toggle

@onready var text_open = $Text_open
@onready var text_close = $Text_close
@onready var officer_sprite = $Text_open/Officer_img
@onready var space_event_list = $Text_open/SpaceEventsList
@onready var human_event_list = $Text_open/HumanEventsList
@onready var nature_event_list = $Text_open/NatureEventsList
@onready var dept_label = $Text_open/Label

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
		space_event_list.add_child(e)
	elif dept == Events.DEPT.HUMAN:
		e.init_event(event, "Monroe")
		human_event_list.add_child(e)
	elif dept == Events.DEPT.NATURE:
		e.init_event(event, "Reyes")
		nature_event_list.add_child(e)

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
		

func _on_space_icon_pressed() -> void:
	Events.cur_dept = Events.DEPT.SPACE
	space_event_list.visible = true
	human_event_list.visible = false
	nature_event_list.visible = false
	dept_label.text = "Department of Space Security"
	
func _on_human_icon_pressed() -> void:
	Events.cur_dept = Events.DEPT.HUMAN
	space_event_list.visible = false
	human_event_list.visible = true
	nature_event_list.visible = false
	dept_label.text = "Department of Homeland Security"

func _on_nature_icon_pressed() -> void:
	Events.cur_dept = Events.DEPT.NATURE
	space_event_list.visible = false
	human_event_list.visible = false
	nature_event_list.visible = true
	dept_label.text = "Department of Environmental Security"
