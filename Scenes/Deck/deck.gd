class_name Deck
extends Node2D

@export var base_deck: DeckTemplate
@export var is_dealer_deck: bool

static var num_cards: int = 0
static var card_indexes: Array

func _ready():
	if base_deck:
		for card in base_deck.cards:
			add_card(card.instantiate())
		shuffle_deck()

func play_card(index: int):
	var array_index = card_indexes.find(index)
	var card = get_child(index)
	card.do_action(null)
	var removed_card = card_indexes.pop_at(array_index)
	card_indexes.append(removed_card)
	print(str(card_indexes))

func add_card(card: GameCard):
	card.card_index = num_cards
	card_indexes.append(num_cards)
	num_cards += 1
	add_child(card)
	
func delete_card(card: GameCard):
	var deleted_card = find_child(card.name, false)
	if deleted_card:
		card_indexes.erase(deleted_card.card_index)
		num_cards -= 1
		deleted_card.queue_free()

func shuffle_deck():
	card_indexes.shuffle()
	print(str(card_indexes))

