class_name StatusBar extends HBoxContainer

var shield: int = 0: set = _set_shield

@export var shield_icon: TextureRect

func _set_shield(x) -> void:
	if x > 0:
		shield_icon.show()
		shield_icon.get_node("Amount").text = str(x)
	else:
		shield_icon.hide()
