extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		if visible == false:
			get_tree().paused = true
			visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().paused = false
			visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_cont_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/title_screen.tscn")
