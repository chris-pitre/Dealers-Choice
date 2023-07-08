class_name Deck
extends Resource

const CardScene = preload("res://Scenes/Cards/card.tscn")

@export var base_deck: DeckTemplate
@export var is_dealer_deck: bool
@export var deck_name: String = "DeckName"

var card_array: Array[GameCard] = []

func populate():
	if base_deck:
		for card in base_deck.cards:
			var new_card = CardScene.instantiate()
			add_card(new_card)
			new_card.load_card(card)
		shuffle_deck()

func play_card(target) -> GameCard:
	var card = card_array.pop_front()
	print(deck_name+" does!")
	card.do_action(target)
	return card

func add_card(card: GameCard):
	card_array.append(card)
	
func delete_card(card: GameCard):
	card_array.erase(card)

func shuffle_deck():
	card_array.shuffle()

