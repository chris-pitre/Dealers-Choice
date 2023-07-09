class_name Tommy
extends CustomCardBehavior

func action(user: BattleActor, target: BattleActor) -> void:
	for i in range(10):
		target.damage(1)
