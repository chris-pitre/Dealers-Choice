@tool
class_name Healthbar extends TextureProgressBar

@export var max_health: float = 100.0:
	set = _set_max_health
@export var health: float = 100.0:
	set = _set_health

func _set_health(_health) -> void:
	health = _health
	value = _health
	$Label.text = "%d/%d" % [health, max_health]

func _set_max_health(_max_health) -> void:
	max_health = _max_health
	max_value = _max_health
	$Label.text = "%d/%d" % [health, max_health]
