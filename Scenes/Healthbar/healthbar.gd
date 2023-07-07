@tool
class_name Healthbar extends TextureProgressBar

@export var max_health: int = 100:
	set = _set_max_health
@export var health: int = 100:
	set = _set_health

func _set_health(_health) -> void:
	health = _health
	value = _health
	max_health = max(health, max_health)
	$Label.text = "%d/%d" % [health, max_health]

func _set_max_health(_max_health) -> void:
	max_health = _max_health
	max_value = _max_health
	health = min(health, max_health)
	$Label.text = "%d/%d" % [health, max_health]
