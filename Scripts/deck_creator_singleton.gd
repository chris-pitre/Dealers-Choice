extends Node

@onready var card_array = list_all_card_files()

func list_all_card_files() -> Array[Card]:
	var card_file_array: Array[String] = []
	var card_array: Array[Card] = []
	var path = "res://Assets/CustomResources/Cards/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var card_file = dir.get_next()
		while card_file != "":
			if not dir.current_is_dir():
				card_file_array.append(path + card_file)
			card_file = dir.get_next()
	for card_file in card_file_array:
		card_array.append(load(card_file))
	return card_array

func create_random_deck(size: int) -> Deck:
	var deck = Deck.new()
	for i in range(size):
		var rand_index = randi() %  card_array.size()
		var card = card_array[rand_index]
		deck.cards.append(card)
	return deck
