class_name Cheat
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	var rand_card = load(GeneratorSingleton.card_array[randi() % GeneratorSingleton.card_array.size()])
	rand_card.play_card(user, target)
