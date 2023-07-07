class_name ActionComponent
extends Node

@export var value: int
@export var action: ActionData.ActionTypes

func do_action(target) -> void:
	match action:
		ActionData.ActionTypes.ATTACK:
			print("Attacked for: "+str(value))
			#do an attack
		ActionData.ActionTypes.DEFEND:
			print("Defended for: "+str(value))
			#do a defend
		ActionData.ActionTypes.RUSH:
			print("Rushed for: "+str(value))
			#do a rush
		ActionData.ActionTypes.HEAL:
			print("Healed for: "+str(value))
			#do a heal
			
