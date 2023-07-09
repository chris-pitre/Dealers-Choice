class_name Intimidate
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	if target.data.deck.size() > 0:
		BattleManager.discard.add_card(target.data.deck.remove_top_card())
		target.lose_turn()
