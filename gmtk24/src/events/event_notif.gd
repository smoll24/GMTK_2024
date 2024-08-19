extends Control

@onready var threat_symbol = $Threat_Level
@onready var low_level_label = $Low_Level
@onready var medium_level_label = $Medium_Level
@onready var high_level_label = $High_Level

var tween : Tween
var active_event : ActiveEvent: 
	set(event):
		active_event = event
		$Event_title.text = Events.events_desc[active_event.type][0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	position = Vector2(0,0)

func popup(event : ActiveEvent, category : Events.CATG):
	active_event = event
	
	match category:
		Events.CATG.SMALL:
			threat_symbol.play('small')
			low_level_label.visible = true
			medium_level_label.visible = false
			high_level_label.visible = false
		Events.CATG.MEDIUM:
			threat_symbol.play('medium')
			low_level_label.visible = false
			medium_level_label.visible = true
			high_level_label.visible = false
		Events.CATG.LARGE:
			threat_symbol.play('large')
			low_level_label.visible = false
			medium_level_label.visible = false
			high_level_label.visible = true
	
	visible = true
	tween = create_tween()
	self.modulate.a = 0
	tween.tween_property(self, "modulate:a", 1, 0.2)
	
	await get_tree().create_timer(3).timeout
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(self, "position", Vector2(self.position.x,self.position.y-20), 0.5)
	await tween.finished
	queue_free()

func _process(delta: float) -> void:
	if active_event != null:
		var time_remaining = active_event.countdown
		if time_remaining > 0:
			$Time_label.text = '[Time Remaining] ' + GV.display_countdown(time_remaining)
	else:
		$Time_label.text = '[Time Remaining] ' + GV.display_countdown(0)
