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
<<<<<<< HEAD
@export_flags("Flipped", "Marked") var card_flags = 0: set = _set_card_flags

func _set_card_flags(x) -> void:
	card_flags = x
	flags_changed.emit(x)
=======

func play_card(user: BattleActor, target: BattleActor):
	match action:
		Action.Attack:
			print("Attacking for: ", numbers[0])
			target.damage(numbers[0])
		Action.Defend:
			print("Defending for: ", numbers[0])
			user.defend(numbers[0])
		Action.Rush:
			print("Rushing")
			user.rush()
		Action.Heal:
			print("Healing for: ", numbers[0])
			user.heal(numbers[0])
>>>>>>> 9f7f229d3631fa6f2561b53b57b9f93f1052de77
