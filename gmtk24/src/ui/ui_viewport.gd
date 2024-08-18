extends Control

var text_toggle

@onready var text_open = $Text_open
@onready var text_close = $Text_close
@onready var officer_sprite = $Text_open/Officer_img

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Close text panel
	text_toggle = false
	text_open.visible = false
	text_close.visible = true
	officer_sprite.play()

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
