class_name Dealer extends VBoxContainer


signal dealer_dealt(card: Card)


var deck: Deck: set = _set_deck


@export var top_card: CardDisplay
@export var num_cards_left_label: Label


func _on_shuffle_pressed() -> void:
	deck.shuffle_deck()
	top_card.load_card(deck.cards[0])


func _on_swap_back_pressed() -> void:
	deck.move_card(0, deck.size() - 1)
	top_card.load_card(deck.cards[0])


func _on_mark_pressed() -> void:
	deck.cards[0].card_flags |= Card.CardFlags.Marked


func _on_deal_button_pressed() -> void:
	AudioSingleton.play_sfx(load("res://Assets/SFX/card.wav"))
	dealer_dealt.emit(deck.remove_card(0))
	if deck.cards.size() > 0:
		top_card.load_card(deck.cards[0])
	num_cards_left_label.text = "Num cards left: %d" % deck.size()


func _set_deck(_deck: Deck) -> void:
	deck = _deck
	top_card.load_card(deck.cards[0])
