class_name BattleManager extends Node

const NUM_CARDS_PER_TURN = 1

var battle_queue: Array[BattleActor]

var player: BattleActor : set = _set_player
var enemy: BattleActor : set = _set_enemy

@onready var discard: Deck = Deck.new()

func _set_player(actor: BattleActor) -> void:
	player = actor
	player.actor_start_rush.connect(_do_rush)
	
func _set_enemy(actor: BattleActor) -> void:
	enemy = actor
	enemy.actor_start_rush.connect(_do_rush)

func create_queue() -> void:
	var queue_length = enemy.deck.size() + player.deck.size()
	for i in range(queue_length):
		if i % 2 == 0:
			battle_queue.append(player)
		else:
			battle_queue.append(enemy)
	
func start_battle() -> void:
	while not battle_queue.is_empty():
		var turn = battle_queue.pop_front()
		var opponent = enemy if turn == player else player
		var cards_used = turn.play_cards(NUM_CARDS_PER_TURN, opponent)
		for card in cards_used:
			discard.add_card(card)
		#await end of that turn eventually

## Swaps two turns in the turn queue for rush
func swap_turns(a: int, b: int) -> void:
	var temp = battle_queue[a]
	battle_queue[a] = battle_queue[b]
	battle_queue[b] = temp

## We do a little rushing
func _do_rush(actor: BattleActor):
	var first_index = battle_queue.find(actor)
	if battle_queue.size() - first_index >= 5:
		swap_turns(first_index + 4, first_index + 1)
	elif battle_queue.size() - first_index >= 3:
		swap_turns(first_index + 2, first_index + 1)
	
