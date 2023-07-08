class_name Dealer extends VBoxContainer


signal dealer_dealt(card: Card)


var deck: Deck: set = _set_deck


@export var top_card: CardDisplay


func _on_shuffle_pressed() -> void:
	deck.shuffle_deck()


func _on_swap_back_pressed() -> void:
	deck.move_card(0, deck.size())


func _on_mark_pressed() -> void:
	deck.cards[0].card_flags |= Card.CardFlags.Marked


func _on_deal_button_pressed() -> void:
	dealer_dealt.emit(deck.remove_card(0))


func _set_deck(deck: Deck) -> void:
	deck = deck
	top_card.load_card(deck.cards[0])
