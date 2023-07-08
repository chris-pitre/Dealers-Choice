class_name BattleActor
extends Node2D

@export var actor_name: String = "Dummy"
@export var max_health: int = 30
@export var deck: Deck

signal actor_death(actor_name)

var health: int = -1
var shield: int = 0

func gain_shield(amount: int):
	shield += amount

func take_damage(amount: int):
	if shield > 0:
		shield -= amount
	else:
		health -= amount
	if shield < 0:
		health += shield
	health = clamp(health, 0, max_health)
	shield = 0
	if health == 0:
		emit_signal("actor_death", actor_name)

func heal_damage(amount: int):
	health += amount
	health = clamp(health, 0, max_health)
