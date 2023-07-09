extends Node

var base_deck: Deck = preload("res://Assets/CustomResources/Decks/testdeck.tres")

func get_deck() -> Deck:
	var deck = base_deck.duplicate()
	return deck

func add_card_to_deck(card: Card) -> void:
	base_deck.add_card(card)
