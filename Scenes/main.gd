extends Node

var player_deck: Deck
var enemy_deck: Deck
@export var dealer_deck: Deck
@export var discard_deck: Deck

var turn_manager = preload("res://Scripts/TurnManager/turn_manager.tres")

var player: BattleActor
var enemy: BattleActor
var max_cards_dealt: int
var cards_to_deal: int
var turn_queue: Array[TurnManager.Turns]

signal deal_finished

func _ready():
	#Initializing Different Phases
	turn_manager.start_phase_started.connect(_on_start_phase_started)
	turn_manager.draw_phase_started.connect(_on_draw_phase_started)
	turn_manager.action_phase_started.connect(_on_action_phase_started)
	
	#Initializing Draw Phase Turns
	turn_manager.player_draw_started.connect(_on_player_draw_started)
	turn_manager.enemy_draw_started.connect(_on_enemy_draw_started)
	
	#Initializing Action Phase Turns
	turn_manager.player_turn_started.connect(_on_player_turn_started)
	turn_manager.enemy_turn_started.connect(_on_enemy_turn_started)
	
	$DealerManager.deal_card.connect(_on_deal_card)
	
	get_actors()
	
	player_deck.populate()
	enemy_deck.populate()
	
	print("Starting Start Phase!")
	turn_manager.set_phase(TurnManager.Phases.StartPhase)
	
func get_actors():
	player_deck = $Battlers/Player.deck
	enemy_deck = $Battlers/Enemy.deck
	player = $Battlers/Player
	enemy = $Battlers/Enemy
	player.health = player.health if player.health != -1 else player.max_health
	enemy.health = enemy.max_health

func _on_start_phase_started():
	print("Collecting Cards")
	for i in player_deck.card_array.size():
		var card = player_deck.card_array.pop_front()
		dealer_deck.card_array.append(card)
	for i in enemy_deck.card_array.size():
		var card = enemy_deck.card_array.pop_front()
		dealer_deck.card_array.append(card)
	dealer_deck.shuffle_deck()
	
	max_cards_dealt = dealer_deck.card_array.size()
	
	print("Starting Draw Phase")
	turn_manager.set_phase(TurnManager.Phases.DrawPhase)
	
func _on_draw_phase_started():
	$DealerManager.is_draw_phase = true
	cards_to_deal = floor(max_cards_dealt/3)
	print("Cards to deal: "+str(cards_to_deal))
	turn_manager.set_draws(TurnManager.Draws.Player)
	
func _on_action_phase_started():
	$DealerManager.is_draw_phase = false
	for i in range(player_deck.card_array.size() + enemy_deck.card_array.size()):
		if i % 2 == 0:
			QueueManager.add_turn(TurnManager.Turns.Player)
		else:
			QueueManager.add_turn(TurnManager.Turns.Enemy)
	do_turn()

func do_turn():
	if QueueManager.get_size() <= 0:
		turn_manager.set_phase(TurnManager.Phases.DrawPhase)
	else:
		turn_manager.set_turns(QueueManager.get_turn())
	
func _on_player_draw_started():
	$DealerManager.is_player_draw = true
	await deal_finished
	if cards_to_deal <= 0:
		turn_manager.set_phase(TurnManager.Phases.ActionPhase)
	else:
		turn_manager.set_draws(TurnManager.Draws.Enemy)

func _on_enemy_draw_started():
	$DealerManager.is_player_draw = false
	await deal_finished
	if cards_to_deal <= 0:
		turn_manager.set_phase(TurnManager.Phases.ActionPhase)
	else:
		turn_manager.set_draws(TurnManager.Draws.Player)
	
func _on_deal_card(is_player: bool):
	if dealer_deck.card_array.size() < cards_to_deal:
		for i in discard_deck.card_array.size():
			dealer_deck.card_array.append(discard_deck.card_array.pop_front())
		dealer_deck.shuffle_deck()
	var top_card = dealer_deck.card_array[0]
	dealer_deck.delete_card(top_card)
	if is_player:
		player_deck.add_card(top_card)
	else:
		enemy_deck.add_card(top_card)
	cards_to_deal -= 1
	print("Cards Left: "+str(cards_to_deal))
	emit_signal("deal_finished")
	
func _on_player_turn_started():
	print("Player Health: "+str(player.health))
	var discarded_card = player_deck.play_card(player, enemy)
	discard_deck.card_array.append(discarded_card)
	do_turn()

func _on_enemy_turn_started():
	print("Enemy Health: "+str(enemy.health))
	var discarded_card = enemy_deck.play_card(enemy, player)
	discard_deck.card_array.append(discarded_card)
	do_turn()
