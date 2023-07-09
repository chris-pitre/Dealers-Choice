class_name Deck extends Resource

signal added_card()
signal removed_card(card_index: int)
signal moved_card(first_index: int, second_index: int)
signal combined()
signal shuffled()
signal cleared()
signal card_flags_modified(idx: int, new_flags: int)
signal num_cards_changed(amt: int)

@export var cards: Array[Card] = []

func add_card(card: Card) -> void:
	card = card.duplicate()
	cards.append(card)
	card.flags_changed.connect(_on_card_flags_changed)
	added_card.emit()
	num_cards_changed.emit(cards.size())

func remove_top_card() -> Card:
	return remove_card(0)

func remove_card(card_index: int) -> Card:
	var card = cards.pop_at(card_index)
	removed_card.emit(card_index)
	num_cards_changed.emit(cards.size())
	return card

func move_card(first_index: int, second_index: int) -> void:
	var temp = cards[first_index]
	cards[first_index] = cards[second_index]
	cards[second_index] = temp
	moved_card.emit(first_index, second_index)

func combine(deck: Deck) -> Deck:
	cards.append_array(deck.cards)
	combined.emit()
	num_cards_changed.emit(cards.size())
	return deck

func shuffle_deck() -> void:
	AudioSingleton.play_sfx(load("res://Assets/SFX/shuffle.wav"))
#	for i in range(cards.size()):
#		var random_index = randi() % cards.size()
#		move_card(i, random_index)
	cards.shuffle()
	shuffled.emit()
	
func size() -> int:
	return cards.size()

func clear() -> void:
	cards.clear()
	cleared.emit()
	num_cards_changed.emit(cards.size())

func _on_card_flags_changed(card, flags) -> void:
	card_flags_modified.emit(cards.find(card), flags)
