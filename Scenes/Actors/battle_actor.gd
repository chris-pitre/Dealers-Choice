class_name BattleActor
extends Node2D

@export var actor_name: String = "Dummy"
@export var max_health: int = 30
@export var deck: Deck

signal actor_shield_changed(actor_name, old_value, new_value)
signal actor_health_changed(actor_name, old_value, new_value)
signal actor_death(actor_name)

var health: int = -1
var shield: int = 0

func gain_shield(amount: int):
	var old_shield = shield
	shield += amount
	actor_shield_changed.emit(actor_name, old_shield, shield)

func take_damage(amount: int):
	var old_health = health
	var old_shield = shield
	if shield > 0:
		shield -= amount
		if shield < 0:
			health += shield
	else:
		health -= amount
	health = clamp(health, 0, max_health)
	shield = 0
	if old_shield != shield:
		actor_shield_changed.emit(actor_name, old_shield, shield)
	if old_health != health:
		actor_health_changed.emit(actor_name, old_health, health)
	if health == 0:
		actor_death.emit(actor_name)

func heal_damage(amount: int):
	health += amount
	health = clamp(health, 0, max_health)
