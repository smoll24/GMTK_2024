extends Control

@onready var line_edit = $VBoxContainer/name_input

func _on_submit_button_pressed() -> void:
	Click.play()
	get_tree().change_scene_to_file("res://src/main.tscn")
	GV.CityName = line_edit.text

func _on_name_input_text_submitted(new_text: String) -> void:
	line_edit.release_focus()
	GV.CityName = new_text
