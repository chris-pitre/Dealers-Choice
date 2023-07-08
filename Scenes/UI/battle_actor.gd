class_name BattleActor extends VBoxContainer

signal actor_rush_start(actor: BattleActor)
signal actor_shield_changed(actor: BattleActor, old_value: int, new_value: int)
signal actor_health_changed(actor: BattleActor, old_value: int, new_value: int)
signal actor_death(actor: BattleActor)

var shield: int = 0

@export var deck_display: DeckDisplay
@export var data: BattleActorData
@export var healthbar: Healthbar
@export var is_player: bool = false

func _ready() -> void:
	deck_display.deck = data.deck


func play_cards(num: int, target: BattleActor) -> Array[Card]:
	var card_array: Array[Card] = []
	for i in range(num):
		var card = data.deck.remove_top_card()
		card_array.append(card)
		card.play_card(self, target)
	await get_tree().create_timer(0.5).timeout
	return card_array


func damage(x: int) -> void:
	var old_health = data.health
	var old_shield = shield
	if shield > 0:
		shield -= x
		if shield < 0:
			data.health += shield
	else:
		data.health -= x
	data.health = clamp(data.health, 0, data.max_health)
	shield = 0
	if old_shield != shield:
		actor_shield_changed.emit(self, old_shield, shield)
	if old_health != data.health:
		actor_health_changed.emit(self, old_health, data.health)
	if data.health == 0:
		actor_death.emit(self)
	healthbar.health = data.health
	healthbar.max_health = data.max_health

func defend(x: int) -> void:
	var old_shield = shield
	shield += x
	actor_shield_changed.emit(self, old_shield, shield)

func heal(x: int) -> void:
	var old_health = data.health
	data.health += x
	data.health = clamp(data.health, 0, data.max_health)
	actor_health_changed.emit(self, old_health, data.health)
	healthbar.health = data.health
	healthbar.max_health = data.max_health

func rush() -> void:
	actor_rush_start.emit(self)
