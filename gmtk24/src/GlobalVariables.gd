extends Node

var aspect_ratio = Vector2i(16,9)
var viewport_size : Vector2

var resource : Dictionary = {
	'people' : {'amount' : 5000, 'growth' : 10},
	'food' : {'amount' : 5000, 'growth' : 10},
	'lumber' : {'amount' : 5000, 'growth' : 10},
	'metal' : {'amount' : 5000, 'growth' : 10},
	'energy' : {'amount' : 5000, 'growth' : 10},
	'finance' : {'amount' : 5000, 'growth' : 10},
	'comms' : {'amount' : 5000, 'growth' : 10},
}

const SEC_IN_MIN : int = 60
const SEC_IN_HOUR : int = SEC_IN_MIN * 60
const SEC_IN_DAY : int = SEC_IN_HOUR * 24
const SEC_IN_YEAR : int = SEC_IN_DAY * 365.25

func _ready():
	viewport_size = get_viewport().get_visible_rect().size
	#rescale_window()

func get_screen_size() -> Vector2:
	return viewport_size

func seconds_to_calendar(time_in_sec) -> Dictionary:
	var sec = time_in_sec
	var years = int(sec/SEC_IN_YEAR)
	var days = int((sec - years * SEC_IN_YEAR)/SEC_IN_DAY)
	
	sec = int(time_in_sec)
	var hours = ((sec/60)/60)%24
	var minutes = (sec/60)%60
	var seconds = sec % 60
	
	return {'year' : years,
			'day' : days,
			'hour' : hours,
			'minute' : minutes,
			'second' : seconds}

func display_time_from_seconds(time_in_sec) -> String:
	#return str(Time.get_datetime_dict_from_unix_time(time_in_sec))
	var calendar_time : Dictionary = seconds_to_calendar(time_in_sec)
	var seconds = calendar_time['second']
	var minutes = calendar_time['minute']
	var hours = calendar_time['hour']
	var days = calendar_time['day']
	var years = calendar_time['year']
	
	var time : String = "%02d:%02d:%02d" % [hours, minutes, seconds]
	if days > 0:
		time = "Day %02d " % [days + 2] + time
	if years > 0:
		time = "Year %s " % [format_number(years + 1970)] + time
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
