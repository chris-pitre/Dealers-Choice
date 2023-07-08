extends Node

@export var player_deck: Deck
@export var enemy_deck: Deck
@export var dealer_deck: Deck

var turn_manager = preload("res://Scripts/TurnManager/turn_manager.tres")

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
	
	player_deck.populate()
	enemy_deck.populate()
	
	print("Starting Start Phase!")
	turn_manager.set_phase(TurnManager.Phases.StartPhase)

func _on_start_phase_started():
	print("Collecting Cards")
	for i in player_deck.card_array.size():
		var card = player_deck.card_array.pop_front()
		dealer_deck.card_array.append(card)
	for i in enemy_deck.card_array.size():
		var card = enemy_deck.card_array.pop_front()
		dealer_deck.card_array.append(card)
	dealer_deck.shuffle_deck()
	
	print("Starting Draw Phase")
	turn_manager.set_phase(TurnManager.Phases.DrawPhase)
	
func _on_draw_phase_started():
	$DealerManager.is_draw_phase = true
	cards_to_deal = floor(dealer_deck.card_array.size()/3)
	print("Cards to deal: "+str(cards_to_deal))
	turn_manager.set_draws(TurnManager.Draws.Player)
	
func _on_action_phase_started():
	$DealerManager.is_draw_phase = false
	for i in range(player_deck.card_array.size() + enemy_deck.card_array.size()):
		if i % 2 == 0:
			turn_queue.append(TurnManager.Turns.Player)
		else:
			turn_queue.append(TurnManager.Turns.Enemy)
	do_turn()

func do_turn():
	if turn_queue.size() <= 0:
		print("help")
	else:
		turn_manager.set_turns(turn_queue.pop_front())
	
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
	player_deck.play_card(null)
	do_turn()

func _on_enemy_turn_started():
	enemy_deck.play_card(null)
	do_turn()
