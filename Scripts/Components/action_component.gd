class_name ActionComponent
extends Node

@export var value: int
@export var action: ActionData.ActionTypes

func do_action(actor: BattleActor, target: BattleActor) -> void:
	match action:
		ActionData.ActionTypes.ATTACK:
			print("Attacked for: "+str(value))
			target.take_damage(value)
		ActionData.ActionTypes.DEFEND:
			print("Defended for: "+str(value))
			actor.gain_shield(value)
		ActionData.ActionTypes.RUSH:
			print("Rushed!")
			QueueManager.rush(actor)
		ActionData.ActionTypes.HEAL:
			print("Healed for: "+str(value))
			actor.heal_damage(value)
			
