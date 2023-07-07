extends Node

var turn_manager = preload("res://Scripts/TurnManager/turn_manager.gd")

func _ready():
	turn_manager.player_draw_started.connect(_on_player_draw_started())
	turn_manager.enemy_draw_started.connect(_on_enemy_draw_started())
	turn_manager.action_phase_started.connect(_on_action_phase_started())
	turn_manager.player_turn_started.connect(_on_player_turn_started())
	turn_manager.enemy_turn_started.connect(_on_enemy_turn_started())

func _on_player_draw_started():
	pass

func _on_enemy_draw_started():
	pass

func _on_action_phase_started():
	pass
	
func _on_player_turn_started():
	pass

func _on_enemy_turn_started():
	pass
