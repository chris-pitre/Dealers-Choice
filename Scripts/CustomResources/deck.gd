class_name Deck extends Resource

signal added_card()
signal removed_card(card_index: int)
signal moved_card(first_index: int, second_index: int)
signal combined()
signal card_flags_modified(idx: int, new_flags: int)

@export var cards: Array[Card] = []

func add_card(card: Card) -> void:
	card = card.duplicate()
	cards.append(card)
	card.flags_changed.connect(_on_card_flags_changed)
	added_card.emit()

func remove_top_card() -> Card:
	return remove_card(0)

func remove_card(card_index: int) -> Card:
	var card = cards.pop_at(card_index)
	removed_card.emit(card_index)
	return card

func move_card(first_index: int, second_index: int) -> void:
	var temp = cards[first_index]
	cards[first_index] = cards[second_index]
	cards[second_index] = temp
	moved_card.emit(first_index, second_index)

func combine(deck: Deck) -> Deck:
	cards.append_array(deck.cards)
	return deck

func shuffle_deck() -> void:
	for i in range(cards.size()):
		var random_index = randi() % cards.size()
		move_card(i, random_index)
	
func size() -> int:
	return cards.size()

func _on_card_flags_changed(card, flags) -> void:
	card_flags_modified.emit(cards.find(card), flags)
