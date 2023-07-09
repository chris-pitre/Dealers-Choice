class_name BattleActor extends VBoxContainer

enum STATUSES{
	DEFENSE,
}

signal actor_rush_start(actor: BattleActor)
signal actor_death(actor: BattleActor)

@export var deck_display: DeckDisplay
@export var data: BattleActorData
@export var healthbar: Healthbar
@export var statuses: StatusBar
@export var portrait_sprite: TextureRect
@export var is_player: bool = false

func _ready() -> void:
	if data.deck == null:
		data.deck = await DeckCreatorSingleton.create_random_deck(randi() % 7 + 6)
	deck_display.deck = data.deck
	load_data()

func load_data() -> void:
	healthbar.max_health = data.max_health
	healthbar.health = data.health
	portrait_sprite.texture = data.portrait

func play_cards(num: int, target: BattleActor) -> Array[Card]:
	var card_array: Array[Card] = []
	for i in range(num):
		var card = data.deck.remove_top_card()
		card_array.append(card)
		card.play_card(self, target)
	await get_tree().create_timer(0.8).timeout
	return card_array


func damage(x: int) -> void:
	if data.shield > 0:
		data.shield -= x
		if data.shield < 0:
			data.health += data.shield
	else:
		data.health -= x
	data.health = clamp(data.health, 0, data.max_health)
	data.shield = 0
	if data.health == 0:
		actor_death.emit(self)
	healthbar.health = data.health
	healthbar.max_health = data.max_health
	update_statuses()

func defend(x: int) -> void:
	data.shield += x
	update_statuses()

func heal(x: int) -> void:
	data.health += x
	data.health = clamp(data.health, 0, data.max_health)
	healthbar.health = data.health
	healthbar.max_health = data.max_health

func rush() -> void:
	actor_rush_start.emit(self)

func update_statuses() -> void:
	statuses.shield = data.shield
