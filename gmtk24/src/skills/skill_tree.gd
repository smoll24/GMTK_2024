extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

signal fast_forward_upgrade
signal buy_cryo_freeze
signal buy_shelters

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buy_citizens_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.PEOPLE]['amount'] += 1000

func _on_power_plants_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.ENERGY]['amount'] += 1000

func _on_fast_forward_level_up(_new_level) -> void:
	Click.play()
	emit_signal("fast_forward_upgrade")

func _on_cryo_freezer_level_up(_new_level) -> void:
	Click.play()
	emit_signal("buy_cryo_freeze")

func _on_build_banks_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.FINANCE]['amount'] += 1000

func _on_buy_wood_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.LUMBER]['amount'] += 1000

func _on_buy_metal_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.METAL]['amount'] += 1000

func _on_buy_cooms_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.COMMS]['amount'] += 1000

func _on_make_dams_level_up(_new_level) -> void:
	Click.play()
	pass # Replace with function body.

func _on_buy_food_level_up(_new_level) -> void:
	Click.play()
	GV.res_dict[GV.RES.FOOD]['growth'] += 1000

func _on_up_shelters_level_up(_new_level) -> void:
	Click.play()
	emit_signal("buy_shelters")
