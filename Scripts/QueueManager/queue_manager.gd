extends Node

var turn_queue: Array[TurnManager.Turns]

func add_turn(turn: TurnManager.Turns) -> void:
	turn_queue.append(turn)

func get_turn() -> TurnManager.Turns:
	return turn_queue.pop_front()
	
func get_size() -> int:
	return turn_queue.size()

func swap(a: int, b: int) -> void:
	var temp = turn_queue[a]
	turn_queue[a] = turn_queue[b]
	turn_queue[b] = temp

func rush(actor: BattleActor):
	var rushed_turn = TurnManager.Turns.Player if actor.actor_name == "Player" else TurnManager.Turns.Enemy
	var first_index = turn_queue.find(rushed_turn)
	if get_size() - first_index >= 5:
		swap(first_index + 4, first_index + 1)
	elif get_size() - first_index >= 3:
		swap(first_index + 2, first_index + 1)
