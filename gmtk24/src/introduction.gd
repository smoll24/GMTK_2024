extends Control

@onready var line_edit = $VBoxContainer/name_input

func _on_submit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main.tscn")

func _on_name_input_text_submitted(new_text: String) -> void:
	line_edit.release_focus()
	GV.CityName = line_edit.text
