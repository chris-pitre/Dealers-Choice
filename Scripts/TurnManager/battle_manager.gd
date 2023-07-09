class_name BattleManager extends Node

const NUM_CARDS_PER_TURN = 1

var battle_queue: Array[BattleActor]

var player: BattleActor : set = _set_player
var enemy: BattleActor : set = _set_enemy

@onready var discard: Deck = Deck.new()

signal turn_changed(actor: BattleActor)
signal battle_ended

func _set_player(actor: BattleActor) -> void:
	player = actor
	player.actor_rush_start.connect(_do_rush)
	
func _set_enemy(actor: BattleActor) -> void:
	enemy = actor
	enemy.actor_rush_start.connect(_do_rush)

func create_queue() -> void:
	var queue_length = enemy.data.deck.size() + player.data.deck.size()
	for i in range(queue_length):
		if i % 2 == 0:
			battle_queue.append(player)
		else:
			battle_queue.append(enemy)
	
func start_battle() -> void:
	while not battle_queue.is_empty():
		var turn = battle_queue[0]
		turn_changed.emit(turn)
		var opponent = enemy if turn == player else player
		var cards_used = await turn.play_cards(NUM_CARDS_PER_TURN, opponent)
		for card in cards_used:
			discard.add_card(card)
		battle_queue.pop_front()
		#await end of that turn eventually
	battle_ended.emit()

## Swaps two turns in the turn queue for rush
func swap_turns(first_index: int, target_index: int, actor: BattleActor) -> void:
	var swap_illegal = true
	var swap_index = first_index
	while swap_illegal:
		swap_index += 1
		if swap_index >= battle_queue.size():
			break
		swap_illegal = battle_queue[swap_index] == actor
	if not swap_illegal:
		var temp = battle_queue[swap_index]
		battle_queue[swap_index] = battle_queue[target_index]
		battle_queue[target_index] = temp
	

## We do a little rushing
func _do_rush(actor: BattleActor):
	var first_index = battle_queue.find(actor)
	var second_index = battle_queue.find(actor, first_index+1)
	var third_index = battle_queue.find(actor, second_index+1)
	if second_index != -1 and battle_queue.size() > 2:
		swap_turns(first_index, second_index, actor)
	if third_index != -1 and battle_queue.size() > 4:
		swap_turns(first_index, third_index, actor)
	
