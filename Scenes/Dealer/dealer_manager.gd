class_name DealerManager
extends Node

var is_player_draw: bool = false
var is_draw_phase: bool = false

signal deal_card(is_player)

func _ready():
	pass

func _input(event):
	if is_draw_phase:
		if event.is_action_pressed("ui_accept") and is_player_draw:
			deal_card.emit(true)
		elif event.is_action_pressed("ui_accept"):
			deal_card.emit(false)
