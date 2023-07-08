class_name BattleManager extends Node

const NUM_CARDS_PER_TURN = 1

var battle_queue: Array[BattleActor]

var player: BattleActor : set = _set_player
var enemy: BattleActor : set = _set_enemy

func _set_player(actor: BattleActor) -> void:
	player = actor
	
func _set_enemy(actor: BattleActor) -> void:
	enemy = actor

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
		turn.play_cards(NUM_CARDS_PER_TURN)
		#await end of that turn eventually

## Swaps two turns in the turn queue for rush
func swap_turns(a: int, b: int) -> void:
	var temp = battle_queue[a]
	battle_queue[a] = battle_queue[b]
	battle_queue[b] = temp
