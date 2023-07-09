class_name Battle extends Control

const CARD_DISPLAY = preload("res://Scenes/UI/card_display.tscn")

@export var battle_manager: BattleManager
@export var dealer: Dealer
@export var battle_actor_left: BattleActor
@export var battle_actor_right: BattleActor

@onready var spinner = $Spinner
@onready var current_target_actor = battle_actor_left

func _ready() -> void:
	battle_manager.battle_ended.connect(_on_battle_end)
	starting_phase()


func starting_phase() -> void:
	shuffle_decks_in([battle_actor_left.data.deck.cards, battle_actor_right.data.deck.cards])
	await get_tree().create_timer(0.5).timeout
	dealing_phase()


func dealing_phase() -> void:
	current_target_actor = battle_actor_left
	spinner.change_spinner(battle_actor_left)
	dealer.show()


func attack_phase() -> void:
	dealer.hide()
	
	if battle_manager.player == null:
		battle_manager.player = battle_actor_left
	if battle_manager.enemy == null:
		battle_manager.enemy = battle_actor_right
	
	print("-------------------------------------")
	
	battle_manager.create_queue()
	battle_manager.start_battle()

func shuffle_decks_in(decks: Array) -> void:
	var new_deck = Deck.new()
	for deck in decks:
		new_deck.cards.append_array(deck)
		deck.clear()
	new_deck.shuffle_deck()
	dealer.deck = new_deck

func get_new_battle() -> void:
	pass


func _on_dealer_dealer_dealt(card: Card) -> void:
	current_target_actor.data.deck.add_card(card)
	current_target_actor = battle_actor_left if current_target_actor == battle_actor_right else battle_actor_right
	spinner.change_spinner(current_target_actor)
	if dealer.deck.size() <= 0:
		attack_phase()

func _on_battle_end() -> void:
	await get_tree().create_timer(0.5).timeout
	shuffle_decks_in([battle_manager.discard.cards])
	await get_tree().create_timer(0.5).timeout
	dealing_phase()
