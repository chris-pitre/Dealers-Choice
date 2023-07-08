class_name Deck extends Resource

signal added_card
signal removed_card
signal moved_card

@export var cards: Array[Card] = []

func add_card(card: Card) -> void:
	cards.append(card)
	added_card.emit()

func remove_top_card() -> Card:
	return remove_card(0)

func remove_card(card_index: int) -> Card:
	var card = cards.pop_at(card_index)
	removed_card.emit()
	return card

func move_card(first_index: int, second_index: int) -> void:
	var temp = cards[first_index]
	cards[first_index] = cards[second_index]
	cards[second_index] = temp
	moved_card.emit()
	
func shuffle_deck():
	for i in range(cards.size()):
		var random_index = randi() % cards.size()
		move_card(i, random_index)
	
func size() -> int:
	return cards.size()
