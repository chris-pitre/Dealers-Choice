extends Node

var turn_manager = preload("res://Scripts/TurnManager/turn_manager.gd")

func _ready():
	#Initializing Different Phases
	turn_manager.start_phase_started.connect(_on_start_phase_started())
	turn_manager.draw_phase_started.connect(_on_draw_phase_started())
	turn_manager.action_phase_started.connect(_on_action_phase_started())
	
	#Initializing Draw Phase Turns
	turn_manager.player_draw_started.connect(_on_player_draw_started())
	turn_manager.enemy_draw_started.connect(_on_enemy_draw_started())
	
	#Initializing Action Phase Turns
	turn_manager.player_turn_started.connect(_on_player_turn_started())
	turn_manager.enemy_turn_started.connect(_on_enemy_turn_started())

func _on_start_phase_started():
	pass
	
func _on_draw_phase_started():
	pass

func _on_action_phase_started():
	pass
	
func _on_player_draw_started():
	pass

func _on_enemy_draw_started():
	pass
	
func _on_player_turn_started():
	pass

func _on_enemy_turn_started():
	pass
