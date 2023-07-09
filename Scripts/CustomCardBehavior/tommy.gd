class_name Tommy
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	for i in range(3):
		target.damage(2)
