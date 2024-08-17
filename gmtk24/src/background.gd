extends Control

@onready var roration_point = $Control
@onready var sun = $Control/Sun
@onready var sky = $Sky

var day_modulate = Color(1,1,1)
var night_modulate = Color(61.0/255.0, 41.0/255.0, 66.0/255.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	roration_point.rotation_degrees -= (delta/(60*60*24))*360
	var sun_pos : Vector2 = sun.get_global_position()
	var screen_size = GlobalVariables.get_screen_size()
	sky.texture.fill_from = Vector2(sun_pos.x/screen_size.x,1)
	
	var sun_deg = int(roration_point.rotation_degrees) % 360
	if sun_deg < -80 and sun_deg > -260:
		sky.self_modulate = sky.self_modulate.lerp(night_modulate, min(delta/(360*15), 0.1))
	else:
		sky.self_modulate = sky.self_modulate.lerp(day_modulate, min(delta/(360*15), 0.1))
