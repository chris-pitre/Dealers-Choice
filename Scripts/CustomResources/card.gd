class_name Card extends Resource

enum Action{Attack, Defend, Rush, Heal}

@export var name: String = "TestCard"
@export_multiline var description: String = "This is a description."
@export var sprite: Texture
@export var numbers: Array[int] = []
@export var action: Action 

func play_card(user: BattleActor, target: BattleActor):
	match action:
		Action.Attack:
			print("Attacking for: ", numbers[0])
			target.damage(numbers[0])
		Action.Defend:
			print("Defending for: ", numbers[0])
			user.defend(numbers[0])
		Action.Rush:
			print("Rushing")
			user.rush()
		Action.Heal:
			print("Healing for: ", numbers[0])
			user.heal(numbers[0])
