class_name Status extends Resource

enum TYPES {
	DEFENSE,
}

@export var type: TYPES = TYPES.DEFENSE
@export var amt: int = 0


func _init(_type, _amt):
	type = _type
	amt = _amt
