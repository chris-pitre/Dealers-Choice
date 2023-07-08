class_name Card extends Resource

enum Action{Attack = 1, 
	Defend = 2, 
	Rush = 4, 
	Heal = 8,
	Custom = 16,
}
enum CardFlags{
	Flipped = 1,
	Marked = 2,
}

signal flags_changed(card: Card, new_flags: int)

@export var name: String = "TestCard"
@export_multiline var description: String = "This is a description."
@export var sprite: Texture
@export var numbers: Array[int] = []
@export var custom_behavior: CustomCardBehavior

@export_flags("Attack", "Defend", "Rush", "Heal", "Custom") var action = 0: set = _set_action
@export_flags("Flipped", "Marked") var card_flags = 0: set = _set_card_flags

func _set_action(x) -> void:
	action = x

func _set_card_flags(x) -> void:
	card_flags = x
	flags_changed.emit(x)

func play_card(user: BattleActor, target: BattleActor):
	if action & Action.Attack:
		#print("%s used %s for %d damage." % [user.data.name, name, numbers[0]])
		target.damage(numbers[0])
	if action & Action.Defend:
		#print("%s used %s for %d defense." % [user.data.name, name, numbers[0]])
		user.defend(numbers[0])
	if action & Action.Rush:
		#print("%s rushed." % [user.data.name])
		user.rush()
	if action & Action.Heal:
		#print("%s is healing for %d" % [user.data.name, numbers[0]])
		user.heal(numbers[0])
	if action & Action.Custom:
		if custom_behavior:
			custom_behavior.action(user, target)
