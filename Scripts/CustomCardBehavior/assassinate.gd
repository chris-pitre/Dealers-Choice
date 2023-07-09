class_name Assassinate
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	target.damage(15)
	target.rush()
