extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.self_modulate = Color(1,1,1,1)

func _on_mouse_entered() -> void:
	self.self_modulate = Color(1.5,1.5,1.5,1.5)

func _on_mouse_exited() -> void:
	self.self_modulate = Color(1,1,1,1)
