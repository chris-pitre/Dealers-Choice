class_name BattleActor extends Control


var battle_manager
var active_turn: bool = false


var deck: Deck = Deck.new()
@export var deck_display: DeckDisplay



func _ready() -> void:
	deck_display.deck = deck


func play_cards(num: int) -> void:
	pass


func damage(x: int) -> void:
	pass


func heal(x: int) -> void:
	pass
