extends Node
class_name GameTime

var seconds : float = 0.0
var year : int = 0

const SEC_IN_YEAR = 60*60*24*365

func _init(s : float, y : int) -> void:
	seconds = s
	year = y

func set_time(s : float, y : int) -> void:
	seconds = s
	year = y

func add(add_seconds : float) -> void:
	var add_years = int(add_seconds/SEC_IN_YEAR)
	add_seconds -= add_years*SEC_IN_YEAR
	
	print('add_years:',add_years)
	print('add_sec:',add_seconds)
	
	seconds += add_seconds
	year += add_years
	if seconds >= SEC_IN_YEAR:
		year += 1
		seconds -= SEC_IN_YEAR

func is_bigger_than(other_time : GameTime) -> bool:
	if self.seconds > other_time.seconds or self.year > other_time.year:
		return true
	return false

func print() -> String:
	return '%s, %s' % [seconds, year]
