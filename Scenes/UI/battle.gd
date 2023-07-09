class_name Battle extends Control

signal lost()
signal new_battle

const CARD_DISPLAY = preload("res://Scenes/UI/card_display.tscn")
const ROUND_RATIO = 0.4

@export var battle_manager: BattleManager
@export var dealer: Dealer
@export var battle_actor_left: BattleActor
@export var battle_actor_right: BattleActor
@export var draw_pile: DrawPile
@export var discard_pile: DiscardPile
@export var draw_pile_display: DeckDisplay
@export var discard_pile_display: DeckDisplay

var total_cards: int = 0

@onready var spinner = $Spinner
@onready var current_target_actor = battle_actor_left

static var deck: Deck = Deck.new()
static var discard: Deck = Deck.new()

func _ready() -> void:
	battle_manager.battle_ended.connect(_on_battle_end)
	dealer.battle = self
	draw_pile_display.deck = deck
	discard_pile_display.deck = discard
	draw_pile.deck = deck
	discard_pile.deck = discard
	starting_phase()

func starting_phase() -> void:
	total_cards = shuffle_decks_in([battle_actor_left.data.deck, battle_actor_right.data.deck])
	await get_tree().create_timer(0.5).timeout
	await give_dealer_cards()
	dealing_phase()

func dealing_phase() -> void:
	current_target_actor = battle_actor_left
	spinner.change_spinner(battle_actor_left)
	dealer.show()

func attack_phase() -> void:
	dealer.hide()
	await get_tree().create_timer(0.5).timeout
	
	if battle_manager.player == null:
		battle_manager.player = battle_actor_left
	if battle_manager.enemy == null:
		battle_manager.enemy = battle_actor_right
	
	battle_manager.create_queue()
	battle_manager.start_battle()

func shuffle_decks_in(decks: Array) -> int:
	for append_deck in decks:
		deck.combine(append_deck)
		append_deck.clear()
	deck.shuffle_deck()
	return deck.size()

func give_dealer_cards() -> void:
	for i in range(floor(total_cards * ROUND_RATIO)):
		if deck.size() == 0:
			shuffle_discard_in()
		var add_card = deck.remove_top_card()
		move_card_anim($DrawPile.position, Vector2(320, 180) - Vector2(64, 96) / 2, add_card)
		dealer.deck.add_card(add_card)
		await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(0.2).timeout
	dealer.top_card.load_card(dealer.deck.cards[0])

func shuffle_discard_in() -> void:
	deck.combine(discard)
	deck.shuffle_deck()
	discard.clear()

func get_new_battle() -> void:
	battle_manager.battle_end = true
	new_battle.emit()

func _on_battle_end() -> void:
	if not battle_manager.battle_end:
		await get_tree().create_timer(0.5).timeout
		give_dealer_cards()
		await get_tree().create_timer(0.5).timeout
		dealing_phase()

func play_card_anim(from: Vector2, card: Card) -> void:
	var moving_card = CARD_DISPLAY.instantiate()
	add_child(moving_card)
	moving_card.hoverable = false
	moving_card.global_position = from
	moving_card.load_card(card)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(
		moving_card,
		"global_position",
		Vector2(320, 180) - Vector2(64, 96) / 2,
		0.3
	)
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	moving_card.velocity = Vector2(randf_range(-100, 100), randf_range(-100, -160))
	moving_card.accel = Vector2(0, 980)
	await get_tree().create_timer(2).timeout
	moving_card.queue_free()

func move_card_anim(from: Vector2, to: Vector2, card: Card) -> void:
	var moving_card = CARD_DISPLAY.instantiate()
	add_child(moving_card)
	moving_card.hoverable = false
	moving_card.global_position = from
	moving_card.load_card(card)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(
		moving_card,
		"global_position",
		to,
		0.3
	)
	await tween.finished
	moving_card.queue_free()

func _on_dealer_dealer_dealt(card: Card) -> void:
	current_target_actor.data.deck.add_card(card)
	move_card_anim(
		Vector2(320, 180) - Vector2(64, 96) / 2,
		current_target_actor.deck_display.global_position + Vector2(0, 96),
		card
	)
	current_target_actor = battle_actor_left if current_target_actor == battle_actor_right else battle_actor_right
	spinner.change_spinner(current_target_actor)
	if dealer.deck.size() <= 0:
		attack_phase()

func _on_battle_actor_played_card(from, card) -> void:
	play_card_anim(from, card)

func _on_battle_actor_2_played_card(from, card) -> void:
	play_card_anim(from, card)

func _on_battle_actor_actor_death(actor) -> void:
	lost.emit()
	get_tree().quit()

func _on_battle_actor_2_actor_death(actor) -> void:
	get_new_battle()

func _on_battle_manager_discard(card) -> void:
	discard.add_card(card)
