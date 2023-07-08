class_name DeckDisplay extends VFlowContainer


var deck: Deck: set = _set_deck


func _ready() -> void:
	if deck:
		_set_deck(deck)


func _set_deck(_deck: Deck) -> void:
	deck = _deck
	deck.added_card.connect(_deck_added_card)
	deck.removed_card.connect(_deck_removed_card)
	deck.moved_card.connect(_deck_moved_card)


func _deck_added_card() -> void:
	pass


func _deck_removed_card() -> void:
	pass


func _deck_moved_card() -> void:
	pass
