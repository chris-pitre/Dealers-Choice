class_name BattleManager extends Node


## This script implements only the fighting given 2+ battle actors, should only know about the two decks


const NUM_CARDS_PER_TURN = 1


var current_turn: BattleActor


var turns: Array[BattleActor] = []


@export var enemy_pool: EnemyPool


func _ready() -> void:
	pass


func get_new_battle() -> void:
	pass


func battle() -> void:
	for turn in turns:
		current_turn = turn
		await take_turn()


func take_turn() -> void:
	pass # take turn off the top - should await animations


