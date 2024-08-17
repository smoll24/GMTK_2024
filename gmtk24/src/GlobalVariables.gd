extends Node

var aspect_ratio = Vector2i(16,9)
var viewport_size : Vector2

func _ready():
	viewport_size = get_viewport().get_visible_rect().size
	#rescale_window()

func get_screen_size() -> Vector2:
	return viewport_size

func seconds_to_calendar(time_in_sec) -> Dictionary:
	time_in_sec = int(time_in_sec)
	var seconds = time_in_sec % 60
	var minutes = (time_in_sec/60)%60
	var hours = ((time_in_sec/60)/60)%24
	var days = (((time_in_sec/60)/60)/24)%365
	var years = (((time_in_sec/60)/60)/24)/365
	
	return {'year' : years,
			'day' : days,
			'hour' : hours,
			'minute' : minutes,
			'second' : seconds}

func display_time_from_seconds(time_in_sec) -> String:
	var calendar_time : Dictionary = seconds_to_calendar(time_in_sec)
	var seconds = calendar_time['second']
	var minutes = calendar_time['minute']
	var hours = calendar_time['hour']
	var days = calendar_time['day']
	var years = calendar_time['year']
	
	var time : String = "%02d:%02d:%02d" % [hours, minutes, seconds]
	
	if days > 0:
		time = "Day %02d " % [days] + time
	if years > 0:
		time = "Year %s " % [format_number(years + 2024)] + time
	return time
	
func format_number(n: int) -> String:
	if n >= 1e9:
		var i:float = snapped(float(n)/1e9, .01)
		return str(i).replace(",", ".") + "B"
	elif n >= 1e6:
		var i:float = snapped(float(n)/1e6, .01)
		return str(i).replace(",", ".") + "M"
	elif n >= 10e3:
		var i:float = snapped(float(n)/1e3, .01)
		return str(i).replace(",", ".") + "k"
	else:
		return str(n)
