class_name Battle extends Control


@export var battle_manager: BattleManager
@export var dealer: Dealer
@export var battle_actor_left: BattleActor
@export var battle_actor_right: BattleActor


@onready var current_target_actor = battle_actor_left


func _ready() -> void:
	starting_phase()


func starting_phase() -> void:
	await get_tree().create_timer(0.5).timeout
	shuffle_decks_in()
	await get_tree().create_timer(0.5).timeout
	dealing_phase()


func dealing_phase() -> void:
	dealer.show()


func attack_phase() -> void:
	dealer.hide()
	
	battle_manager.player = battle_actor_left
	battle_manager.enemy = battle_actor_right
	
	battle_manager.create_queue()
	battle_manager.start_battle()


func shuffle_decks_in() -> void:
	var new_deck = Deck.new()
	new_deck.cards.append_array(battle_actor_left.data.deck.cards)
	new_deck.cards.append_array(battle_actor_right.data.deck.cards)
	new_deck.shuffle_deck()
	dealer.deck = new_deck


func get_new_battle() -> void:
	pass


func _on_dealer_dealer_dealt(card: Card) -> void:
	current_target_actor.data.deck.add_card(card)
	current_target_actor = battle_actor_left if current_target_actor == battle_actor_right else battle_actor_right
	if dealer.deck.size() <= 0:
		attack_phase()
