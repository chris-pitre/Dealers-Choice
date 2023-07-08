class_name DeckDisplay extends HBoxContainer

var deck: Deck

func _ready() -> void:
	deck.added_card.connect(_deck_added_card)
	deck.removed_card.connect(_deck_removed_card)
	deck.moved_card.connect(_deck_moved_card)


func _deck_added_card() -> void:
	pass


func _deck_removed_card() -> void:
	pass


func _deck_moved_card() -> void:
	pass
