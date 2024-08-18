extends Sprite2D

@export var resource_type : GV.RES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$resource_name.text = GV.resource_dict[resource_type]['name']
	update_values()
	
func _process(_delta: float) -> void:
	update_values()

func update_values() -> void:
	var amount = GV.resource_dict[resource_type]['amount']
	$resource_amount.text = GV.format_number(amount)
