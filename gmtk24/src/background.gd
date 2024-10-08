extends Control

@onready var rotation_point = $Control
@onready var sun = $Control/Sun
@onready var sky = $Sky
@onready var city = $City
@onready var city_light_mask = $CityLightMask

@export var sun_day_night : Curve = preload("res://assets/resources/sun_day_night.tres")
@export var sunset_blend : Curve = preload("res://assets/resources/sunset.tres")
@export var sun_height : Curve = preload("res://assets/resources/sun_height.tres")

var day_modulate = Color(1,1,1)
var night_modulate = Color(61.0/255.0, 41.0/255.0, 66.0/255.0)
var summer_modulate = Color(0.39, 0.47, 0.8)
var winter_modulate = Color(0.35,0.44,0.63)
var sunset_color = Color(1,1,0.2)

var final_city_pos = Vector2(-24,-29)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_time(time : float, _delta : float, sim_time_scale : int) -> void:
	var calendar_time = GV.seconds_to_calendar(time)
	var day_time = int(time) % GV.SEC_IN_DAY
	var sun_percent = 1 - float(day_time)/float(GV.SEC_IN_DAY)
	var year_percent = float(calendar_time['day'])/365.0
	var sun_deg = sun_percent * 360
	
	rotation_point.rotation_degrees = sun_deg
	
	var n_people = GV.res_dict[GV.RES.PEOPLE]['amount']
	$City4.position = Vector2(-24,123).lerp(final_city_pos, min(1, n_people/5_000_000))
	
	var day_night_coef : float = sun_day_night.sample_baked(sun_percent)
	var sunset_coef : float = sunset_blend.sample_baked(sun_percent)
	var season_coef : float = sun_day_night.sample_baked(year_percent)
	sun.position.y = 400 + 200 * sun_height.sample_baked(year_percent)
	
	var target_color : Color = day_modulate.lerp(night_modulate, day_night_coef)
	var target_white_color : Color = Color(1,1,1).lerp(sunset_color, sunset_coef)
	var target_sky_color : Color = summer_modulate.lerp(winter_modulate, season_coef)
	var target_city_color : Color = Color(1,1,1).lerp(Color(0.5,0.5,0.5), day_night_coef)
	var target_city_lights : Color = Color(1,1,1,0).lerp(Color(1,1,0.4,0.7), day_night_coef)
	
	sky.texture.gradient.colors[1] = sky.texture.gradient.colors[1].lerp(target_sky_color, 0.05)
	
	if sim_time_scale < GV.SEC_IN_DAY*7:
		var sun_pos : Vector2 = sun.get_global_position()
		var screen_size = GV.get_screen_size()
		sky.texture.fill_from = Vector2(sun_pos.x/screen_size.x,1)
		sky.self_modulate = sky.self_modulate.lerp(target_color, 0.1)
		sky.texture.gradient.colors[0] = target_white_color
		city.self_modulate = city.self_modulate.lerp(target_city_color, 0.05)
		city_light_mask.self_modulate = city_light_mask.self_modulate.lerp(target_city_lights, 0.05)
	else:
		sky.self_modulate = day_modulate.lerp(night_modulate, 0.5)
