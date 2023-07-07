class_name ActionComponent
extends Node

enum ActionTypes {ATTACK, DEFEND, RUSH}

@export var value: int
@export var action: ActionTypes	

func do_action(target) -> void:
	match action:
		ActionTypes.ATTACK:
			print("Attacked for: "+str(value))
			#do an attack
			pass
		ActionTypes.DEFEND:
			print("Defended for: "+str(value))
			#do a defend
			pass
		ActionTypes.RUSH:
			print("Rushed for: "+str(value))
			#do a rush
			pass
