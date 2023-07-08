class_name Healthbar extends TextureProgressBar

var health: int = 0: set = _set_health
var max_health: int = 0: set = _set_max_health

func _set_health(x):
	health = x
	value = x
	$Label.text = "%d/%d" % [health, max_health]

func _set_max_health(x):
	max_health = x
	max_value = x
	$Label.text = "%d/%d" % [health, max_health]
