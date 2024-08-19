extends Button
class_name SkillNode

@onready var skill_level = $SkillLevel
@onready var skill_branch = $SkillBranch

@export var max_level : int = 3
@onready var infinite : bool = false
@export var required_prev_level : int = 1

signal level_up(new_level)

var level : int = 0:
	set(value):
		level = value
		skill_level.text = '%d/%d' % [level, max_level] if not infinite else '%d' % level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 0
	
	var parent_node = get_parent() 
	if parent_node is SkillNode:
		skill_branch.add_point(self.global_position + self.size/2)
		skill_branch.add_point(parent_node.global_position + parent_node.size/2)
		self.disabled = true
		parent_node.level_up.connect(enable_button)

func enable_button(new_level) -> void:
	if new_level >= required_prev_level:
		self.disabled = false
		skill_branch.default_color = Color(1,1,1)

func _on_pressed() -> void:
	level = min(level + 1, max_level) if not infinite else level + 1
	emit_signal("level_up", level)
	self.self_modulate = Color(0.9,0.9,0.9)
