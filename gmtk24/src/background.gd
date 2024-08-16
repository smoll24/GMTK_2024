extends Control

@onready var roration_point = $Control
@onready var sun = $Control/Sun
@onready var sky = $Sky

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	roration_point.rotation -= delta/10
	var sun_pos : Vector2 = sun.get_global_position()
	var screen_size = GlobalVariables.get_screen_size()
	sky.texture.fill_from = Vector2(sun_pos.x/screen_size.x,1)
	print(sky.texture.fill_from)
