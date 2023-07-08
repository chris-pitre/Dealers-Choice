class_name DeckDisplay extends VFlowContainer


const CARD_DISPLAY = preload("res://Scenes/UI/card_display.tscn")


var deck: Deck: set = _set_deck


func _ready() -> void:
	if deck:
		_set_deck(deck)


func _set_deck(_deck: Deck) -> void:
	deck = _deck
	deck.added_card.connect(_deck_added_card)
	deck.removed_card.connect(_deck_removed_card)
	deck.moved_card.connect(_deck_moved_card)
	deck.card_flags_modified.connect(_deck_card_flags_modified)


func _deck_added_card() -> void:
	var new_card_display = CARD_DISPLAY.instantiate()
	add_child(new_card_display)


func _deck_removed_card(card_index: int) -> void:
	get_child(card_index).queue_free()


func _deck_moved_card(first_index: int, second_index: int) -> void:
	move_child(get_child(first_index), second_index)
	#add some anim here later or something

func _deck_card_flags_modified(idx: int, new_flags: int) -> void:
	get_child(idx).display_flags(new_flags)
