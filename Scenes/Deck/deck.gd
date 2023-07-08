class_name Deck
extends Node2D

const CardScene = preload("res://Scenes/Cards/card.tscn")

@export var base_deck: DeckTemplate
@export var is_dealer_deck: bool

var num_cards: int = 0

func _ready():
	if base_deck:
		for card in base_deck.cards:
			var new_card = CardScene.instantiate()
			add_card(new_card)
			new_card.load_card(card)
		shuffle_deck()

func play_card(target):
	var card = get_child(0)
	print(name+" does!")
	card.do_action(target)
	delete_card(card)

func add_card(card: GameCard):
	num_cards += 1
	add_child(card)
	
func delete_card(card: GameCard):
	num_cards -= 1
	remove_child(card)
	card.queue_free()

func shuffle_deck():
	var card_array = get_children()
	card_array.shuffle()
	for card in get_children():
		delete_card(card)
	for card in card_array:
		add_card(card)
