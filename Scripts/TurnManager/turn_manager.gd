class_name TurnManager
extends Resource

enum Turns {PlayerDraw, EnemyDraw, ActionPhase}
enum ActionPhaseTurns {Player, Enemy}

signal player_draw_started()
signal enemy_draw_started()
signal action_phase_started()

signal player_turn_started()
signal enemy_turn_started()

func set_action_phase_turn(value: ActionPhaseTurns):
	match value:
		ActionPhaseTurns.Player: 
			emit_signal("player_turn_started")
		ActionPhaseTurns.Enemy:
			emit_signal("enemy_turn_started")
	
func set_turn(value: Turns):
	match value:
		Turns.PlayerDraw:
			emit_signal("player_draw_started")
		Turns.EnemyDraw:
			emit_signal("enemy_draw_started")
		Turns.ActionPhase:
			emit_signal("action_phase_started")
