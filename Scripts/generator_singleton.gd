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
		deck.cards.append(get_random_card())
	return deck

func create_random_enemy() -> Enemy:
	var enemy = Enemy.new()
	enemy.name = create_name()
	enemy.portrait = load(CharacterTraits.portraits[randi() % CharacterTraits.portraits.size()])
	enemy.max_health = randi() % 31 + 20
	enemy.health = enemy.max_health
	return enemy

func create_name() -> String:
	var r_name: String = CharacterTraits.names[randi() % CharacterTraits.names.size()]
	var has_title: bool = randi() % 2 == 0
	if has_title:
		var r_title: String = CharacterTraits.titles[randi() % CharacterTraits.titles.size()]
		var is_prefix: bool = randi() % 2 == 0
		if is_prefix:
			r_name = r_title+" "+r_name
		else:
			r_name = r_name+" the "+r_title
	return r_name

func get_random_card() -> Card:
	var rand_index = randi() % card_array.size()
	var card = card_array[rand_index]
	return card
