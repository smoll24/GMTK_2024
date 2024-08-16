extends Node

var aspect_ratio = Vector2i(16,9)
var viewport_size : Vector2

func _ready():
	viewport_size = get_viewport().get_visible_rect().size
	#rescale_window()

func get_screen_size() -> Vector2:
	return viewport_size

	
