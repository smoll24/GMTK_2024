extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buy_citizens_pressed() -> void:
	GV.res_dict[GV.RES.PEOPLE]['amount'] += 1000

func _on_up_shelters_editor_description_changed(node: Node) -> void:
	pass # Replace with function body.

func _on_power_plants_pressed() -> void:
	pass # Replace with function body.

func _on_fast_forward_pressed() -> void:
	pass # Replace with function body.

func _on_cryo_freezer_pressed() -> void:
	pass # Replace with function body.

func _on_build_banks_pressed() -> void:
	pass # Replace with function body.

func _on_buy_wood_pressed() -> void:
	pass # Replace with function body.

func _on_buy_metal_pressed() -> void:
	pass # Replace with function body.

func _on_buy_cooms_pressed() -> void:
	pass # Replace with function body.

func _on_make_dams_pressed() -> void:
	pass # Replace with function body.

func _on_buy_food_pressed() -> void:
	pass # Replace with function body.
