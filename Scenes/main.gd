extends Node

var turn_manager = preload("res://Scripts/TurnManager/turn_manager.tres")

var cards_to_deal

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
	
	print("Starting Start Phase!")
	turn_manager.set_phase(TurnManager.Phases.StartPhase)

func _on_start_phase_started():
	print("Collecting Cards")
	for card in $PlayerDeck.get_children():
		$PlayerDeck.delete_card(card)
		$DealerDeck.add_card(card)
	for card in $EnemyDeck.get_children():
		$EnemyDeck.delete_card(card)
		$DealerDeck.add_card(card)
	$DealerDeck.shuffle_deck()
	
	print("Starting Draw Phase")
	turn_manager.set_phase(TurnManager.Phases.DrawPhase)
	
func _on_draw_phase_started():
	cards_to_deal = floor($DealerDeck.num_cards/3)
	print("Cards to deal: "+str(cards_to_deal))
	turn_manager.set_draw_phase_turn(TurnManager.DrawPhaseTurns.Player)
	
func _on_action_phase_started():
	pass
	
func _on_player_draw_started():
	deal_card($PlayerDeck)
	if cards_to_deal <= 0:
		turn_manager.set_phase(TurnManager.Phases.ActionPhase)
	else:
		turn_manager.set_draw_phase_turn(TurnManager.DrawPhaseTurns.Enemy)
	

func _on_enemy_draw_started():
	deal_card($EnemyDeck)
	if cards_to_deal <= 0:
		turn_manager.set_phase(TurnManager.Phases.ActionPhase)
	else:
		turn_manager.set_draw_phase_turn(TurnManager.DrawPhaseTurns.Player)
	
func deal_card(deck: Deck):
	var top_card = $DealerDeck.get_child(0)
	$DealerDeck.delete_card(top_card)
	deck.add_card(top_card)
	cards_to_deal -= 1
	print("Cards Left: "+str(cards_to_deal))
	
func _on_player_turn_started():
	pass

func _on_enemy_turn_started():
	pass
