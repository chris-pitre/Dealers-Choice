class_name ActionComponent
extends Node

enum ActionTypes {ATTACK, DEFEND, RUSH, HEAL}

@export var value: int
@export var action: ActionTypes	

func do_action(target) -> void:
	match action:
		ActionTypes.ATTACK:
			print("Attacked for: "+str(value))
			#do an attack
		ActionTypes.DEFEND:
			print("Defended for: "+str(value))
			#do a defend
		ActionTypes.RUSH:
			print("Rushed for: "+str(value))
			#do a rush
		ActionTypes.HEAL:
			print("Healed for: "+str(value))
			#do a heal
			
