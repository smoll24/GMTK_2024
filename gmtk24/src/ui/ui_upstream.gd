extends Control

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	popup()

func popup():
	visible = true
	tween = create_tween()
	self.modulate.a = 0
	tween.tween_property(self, "modulate:a", 1, 0.2)
	
	await get_tree().create_timer(1).timeout
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(self, "position", Vector2(self.position.x,self.position.y-20), 0.5)
	await tween.finished
	queue_free()
	
