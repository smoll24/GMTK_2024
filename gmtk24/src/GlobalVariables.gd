extends Node

var CityName = "New New York"

var aspect_ratio = Vector2i(16,9)
var viewport_size : Vector2

const SEC_IN_MIN : int = 60
const SEC_IN_HOUR : int = SEC_IN_MIN * 60
const SEC_IN_DAY : int = SEC_IN_HOUR * 24
const SEC_IN_YEAR : int = SEC_IN_DAY * 365.25
const END_GAME_TIME = 4.09968e+16 #1.3 billion years in seconds

enum RES{PEOPLE, FOOD, LUMBER, METAL, ENERGY, FINANCE, COMMS}

var res_dict : Dictionary = {
	RES.PEOPLE : {'name' : 'People', 'amount' : 1000.0, 'growth' : 0.5/SEC_IN_DAY},
	RES.FOOD : {'name' : 'Food','amount' : 5000.0, 'growth' : 1500.0/SEC_IN_DAY},
	RES.LUMBER : {'name' : 'Lumber','amount' : 500.0, 'growth' : 1.0/SEC_IN_DAY},
	RES.METAL : {'name' : 'Metal','amount' : 0.0, 'growth' : 1.0/SEC_IN_DAY},
	RES.ENERGY : {'name' : 'Energy','amount' : 500.0, 'growth' : 1.0/SEC_IN_DAY},
	RES.FINANCE : {'name' : 'Finance','amount' : 750.0, 'growth' : 1.0/SEC_IN_DAY},
	RES.COMMS : {'name' : 'Communication', 'amount' : 100.0, 'growth' : 1.0/SEC_IN_DAY},
}

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

func display_countdown(time_in_sec) -> String:
	var calendar_time : Dictionary = seconds_to_calendar(time_in_sec)
	var seconds = calendar_time['second']
	var minutes = calendar_time['minute']
	var hours = calendar_time['hour']
	var days = calendar_time['day']
	var years = calendar_time['year']
	
	var time : String = "%02d:%02d:%02d" % [hours, minutes, seconds]
	if days > 0:
		time = "%02d days " % days + time
	if years > 0:
		time = "%s years " % format_number(years) + time
	return time

func display_magnitude(time_in_sec) -> String:
	var calendar_time : Dictionary = seconds_to_calendar(time_in_sec)
	
	if calendar_time['year'] > 0:
		return '%s year' % format_number(calendar_time['year'])
	elif calendar_time['day'] > 0:
		return '%02d day' % calendar_time['day']
	elif calendar_time['hour'] > 0:
		return '%02d h' % calendar_time['hour']
	elif calendar_time['minute'] > 0:
		return '%02d m' % calendar_time['minute']
	else:
		return '%02d s' % calendar_time['second']

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

func per_day(value, delta):
	return (float(value) / SEC_IN_DAY) * delta

var starving_counter = 0

func incease_resources(delta) -> void:
	res_dict[RES.FOOD]['amount'] -= per_day(res_dict[RES.PEOPLE]['amount'], delta)
	
	if starving_counter >= 30:
		res_dict[RES.PEOPLE]['amount'] -= (res_dict[RES.PEOPLE]['amount'] - res_dict[RES.FOOD]['amount'])
	if res_dict[RES.FOOD]['amount'] < res_dict[RES.PEOPLE]['amount']:
		starving_counter += per_day(1, delta)
		res_dict[RES.PEOPLE]['amount'] -= per_day((res_dict[RES.PEOPLE]['amount'] - res_dict[RES.FOOD]['amount'])/10, delta)
	else:
		starving_counter = 0
		
	if res_dict[RES.PEOPLE]['amount'] < 0:
		print('GAME OVER')
	
	for res in res_dict.values():
		res['amount'] = max(0, res['amount'] + res['growth'] * delta)

	
	
