class_name Deck extends Resource

signal added_card
signal removed_card
signal moved_card

@export var cards: Array[Card] = []
