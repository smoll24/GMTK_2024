extends Button
class_name SkillNode

@onready var skill_level = $SkillLevel
@onready var skill_branch = $SkillBranch

@export var max_level : int = 3
@export var infinite : bool = false
@export var required_prev_level : int = 1
@export var resources : Dictionary = {GV.RES.PEOPLE : 0,
									  GV.RES.FOOD : 0,
									GV.RES.LUMBER : 0,
									GV.RES.METAL : 0,
									GV.RES.ENERGY : 0,
									GV.RES.FINANCE : 0,
									GV.RES.COMMS : 0}

signal level_up(new_level)

var enabled : bool = false

var level : int = 0:
	set(value):
		level = value
		skill_level.text = '%d/%d' % [level, max_level] if not infinite else '%d' % level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 0
	
	var parent_node = get_parent() 
	if parent_node is SkillNode:
		self.self_modulate = Color(0.322,0.322,0.322)
		skill_branch.add_point(self.global_position + self.size/2)
		skill_branch.add_point(parent_node.global_position + parent_node.size/2)
		self.disabled = true
		parent_node.level_up.connect(enable_button)

func enable_button(new_level) -> void:
	if new_level >= required_prev_level:
		enabled = true

func has_resources() -> bool:
	for res in resources.keys():
		if GV.res_dict[res]['amount'] < resources[res]:
			return false
	return true

func _process(delta: float) -> void:
	if enabled and has_resources():
		self.disabled = false
		skill_branch.default_color = Color(1,1,1)

func _on_pressed() -> void:
	for res in resources.keys():
		GV.res_dict[res]['amount'] -= resources[res]
	
	level = min(level + 1, max_level) if not infinite else level + 1
	emit_signal("level_up", level)
	self.self_modulate = Color(0.9,0.9,0.9)
