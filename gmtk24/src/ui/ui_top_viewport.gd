extends Control

@onready var res_open = $Res_open
@onready var res_close = $Res_close

var res_toggle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Close text panel
	res_toggle = false
	res_open.visible = false
	res_close.visible = true

func _on_close_text_pressed() -> void:
	Click.play()
	if res_toggle:
		res_toggle = false
		res_open.visible = false
		res_close.visible = true

func _on_open_text_pressed() -> void:
	Click.play()
	if not res_toggle:
		res_toggle = true
		res_open.visible = true
		res_close.visible = false
