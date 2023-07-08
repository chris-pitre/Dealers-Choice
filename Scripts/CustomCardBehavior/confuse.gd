class_name Confuse
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	print("%s shuffles %s's deck" % [user.name, target.name])
	target.data.deck.shuffle_deck()
