class_name BattleActor extends Control

var health: int = 30
var max_health: int = 30

var turn_manager: TurnManager
var currently_playing_card: GameCard

@export var actor_data: ActorData
@export var health_bar: Healthbar

## Loads deck, health from an ActorData
func load_deck() -> void:
	pass

func damage(amt: int) -> void:
	pass

## Called when other side is finished playing a card
func _on_turn_manager_alternate() -> void:
	pass
