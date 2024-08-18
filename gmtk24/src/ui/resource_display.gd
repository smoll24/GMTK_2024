extends Sprite2D

@export var resource_type : GlobalVariables.RES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$resource_name.text = GlobalVariables.resource_dict[resource_type]['name']
	update_values()
	
func _process(_delta: float) -> void:
	update_values()

func update_values() -> void:
	var amount = GlobalVariables.resource_dict[resource_type]['amount']
	$resource_amount.text = GlobalVariables.format_number(amount)
