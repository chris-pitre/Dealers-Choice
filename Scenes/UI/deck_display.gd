class_name DeckDisplay extends FlowContainer

signal size_changed(amt: int)

const CARD_DISPLAY = preload("res://Scenes/UI/card_display.tscn")

var deck: Deck: set = _set_deck

@export var hover_direction: Vector2 = Vector2.ZERO
@export var hide_by_default: bool = false

func _ready() -> void:
	if deck:
		_set_deck(deck)


func get_compact_separation() -> int:
	var size_len = size.y if vertical else size.x
	var card_size_len = 96 if vertical else 64
	var sep = floor((size_len - card_size_len * get_child_count()) / (get_child_count() - 1))
	return min(sep, 0)


func add_card(card: Card) -> CardDisplay:
	var new_card_display = CARD_DISPLAY.instantiate()
	add_child(new_card_display)
	if hide_by_default:
		new_card_display.card_back.show()
	new_card_display.hover_direction = hover_direction
	new_card_display.load_card(card)
	if vertical:
		set("theme_override_constants/v_separation", get_compact_separation())
	else:
		set("theme_override_constants/h_separation", get_compact_separation())
	return new_card_display

func reinit_deck() -> void:
	for child in get_children():
		child.queue_free()
	for card in deck.cards:
		add_card(card)

func _set_deck(_deck: Deck) -> void:
	deck = _deck
	deck.added_card.connect(_deck_added_card)
	deck.removed_card.connect(_deck_removed_card)
	deck.moved_card.connect(_deck_moved_card)
	deck.combined.connect(_deck_combined)
	deck.shuffled.connect(_deck_shuffled)
	deck.cleared.connect(_deck_cleared)
	deck.card_flags_modified.connect(_deck_card_flags_modified)
	reinit_deck()

func _deck_added_card() -> void:
	var new_card_display = add_card(deck.cards[deck.size() - 1])
	new_card_display.hide_sprite()
	await get_tree().create_timer(0.3).timeout
	new_card_display.show_sprite()

func _deck_removed_card(card_index: int) -> void:
	if get_child(card_index):
		get_child(card_index).queue_free()
	if vertical:
		set("theme_override_constants/v_separation", get_compact_separation())
	else:
		set("theme_override_constants/h_separation", get_compact_separation())

func _deck_moved_card(first_index: int, second_index: int) -> void:
	move_child(get_child(first_index), second_index)
	var i := 0
	for child in get_children():
		child.load_card(deck.cards[i])
		i += 1

func _deck_card_flags_modified(idx: int, new_flags: int) -> void:
	get_child(idx).display_flags(new_flags)

func _deck_combined() -> void:
	reinit_deck()

func _deck_shuffled() -> void:
	reinit_deck()

func _deck_cleared() -> void:
	for card in get_children():
		card.queue_free()
