extends Control

@onready var city1 = $city1
@onready var city2 = $city2
@onready var city3 = $city3
@onready var city4 = $city4

var tween : Tween
var anim_bool1 = true
var anim_bool2 = false
var time = 0.5
var why = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if anim_bool1:
		anim_down()
	if anim_bool2:
		anim_up()
	
func anim_down():
	anim_bool1 = false
	tween = create_tween()
	tween.parallel().tween_property(city1, "position", Vector2(city1.position.x,city1.position.y-why), time)
	tween.parallel().tween_property(city2, "position", Vector2(city2.position.x,city2.position.y-why), time+0.4)
	tween.parallel().tween_property(city3, "position", Vector2(city3.position.x,city3.position.y-why), time+0.8)
	tween.parallel().tween_property(city4, "position", Vector2(city4.position.x,city4.position.y-why), time+1.2)
	await tween.finished
	anim_bool2 = true
	
func anim_up():
	anim_bool2 = false
	tween = create_tween()
	tween.parallel().tween_property(city1, "position", Vector2(city1.position.x,city1.position.y+why), time)
	tween.parallel().tween_property(city2, "position", Vector2(city2.position.x,city2.position.y+why), time+0.4)
	tween.parallel().tween_property(city3, "position", Vector2(city3.position.x,city3.position.y+why), time+0.8)
	tween.parallel().tween_property(city4, "position", Vector2(city4.position.x,city4.position.y+why), time+1.2)
	await tween.finished
	anim_bool1 = true
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
