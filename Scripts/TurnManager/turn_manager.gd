class_name TurnManager
extends Resource

var current_phase
var current_draw
var current_turn

enum Phases {StartPhase, DrawPhase, ActionPhase}
enum Draws {Player, Enemy}
enum Turns {Player, Enemy}

signal start_phase_started
signal draw_phase_started
signal action_phase_started

signal player_draw_started
signal enemy_draw_started

signal player_turn_started
signal enemy_turn_started

func set_phase(value: Phases):
	current_phase = value
	match value:
		Phases.StartPhase:
			emit_signal("start_phase_started")
		Phases.DrawPhase:
			emit_signal("draw_phase_started")
		Phases.ActionPhase:
			emit_signal("action_phase_started")

func set_draws(value: Draws):
	current_draw = value
	match value:
		Draws.Player:
			emit_signal("player_draw_started")
		Draws.Enemy:
			emit_signal("enemy_draw_started")

func set_turns(value: Turns):
	current_turn = value
	match value:
		Turns.Player: 
			emit_signal("player_turn_started")
		Turns.Enemy:
			emit_signal("enemy_turn_started")
			


