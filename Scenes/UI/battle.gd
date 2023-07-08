class_name Battle extends Control


var current_target_actor = battle_actor_left


@export var battle_manager: BattleManager
@export var dealer: Dealer
@export var battle_actor_left: BattleActor
@export var battle_actor_right: BattleActor


func _ready() -> void:
	battle_actor_left.battle_manager = battle_manager
	battle_actor_right.battle_manager = battle_manager


func _on_dealer_dealer_dealt(card: Card) -> void:
	battle_actor_left.deck.add_card(card)
