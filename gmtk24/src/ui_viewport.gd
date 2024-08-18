extends Control

var text_toggle

@onready var text_open = $Text_open
@onready var text_close = $Text_close
@onready var officer_sprite = $Text_open/Officer_img

@onready var open_button = $Text_close/Open_text
@onready var close_button = $Text_open/Close_text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Close text panel
	text_toggle = false
	text_open.visible = false
	text_close.visible = true
	officer_sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

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
		
func _on_close_text_mouse_entered() -> void:
	if close_button:
		close_button.modulate = Color(1.5,1.5,1.5,1.5)

func _on_close_text_mouse_exited() -> void:
	if close_button:
		close_button.modulate = Color(1,1,1,1)

func _on_open_text_mouse_entered() -> void:
	if open_button:
		open_button.modulate = Color(1.5,1.5,1.5,1.5)

func _on_open_text_mouse_exited() -> void:
	if open_button:
		open_button.modulate = Color(1,1,1,1)
