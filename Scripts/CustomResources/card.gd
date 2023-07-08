class_name Card extends Resource

enum Action{Attack, Defend, Rush, Heal}
enum CardFlags{
	Flipped = 1,
	Marked = 2,
}

signal flags_changed(card: Card, new_flags: int)

@export var name: String = "TestCard"
@export_multiline var description: String = "This is a description."
@export var sprite: Texture
@export var numbers: Array[int] = []
@export var action: Action 
@export_flags("Flipped", "Marked") var card_flags = 0: set = _set_card_flags

func _set_card_flags(x) -> void:
	card_flags = x
	flags_changed.emit(x)
