class_name Intimidate
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	if target.data.deck.size() > 0:
		var card = target.data.deck.remove_top_card()
		Battle.discard.add_card(card)
		target.lose_turn()
