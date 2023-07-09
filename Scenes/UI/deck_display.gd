class_name DeckDisplay extends VFlowContainer


const CARD_DISPLAY = preload("res://Scenes/UI/card_display.tscn")


var deck: Deck: set = _set_deck


@export var hover_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	if deck:
		_set_deck(deck)


func get_compact_separation() -> int:
	var sep = floor((size.y - 96.0 * get_child_count()) / (get_child_count() - 1))
	return min(sep, 0)


func _set_deck(_deck: Deck) -> void:
	deck = _deck
	deck.added_card.connect(_deck_added_card)
	deck.removed_card.connect(_deck_removed_card)
	deck.moved_card.connect(_deck_moved_card)
	deck.card_flags_modified.connect(_deck_card_flags_modified)


func _deck_added_card() -> void:
	var new_card_display = CARD_DISPLAY.instantiate()
	add_child(new_card_display)
	new_card_display.hover_direction = hover_direction
	new_card_display.load_card(deck.cards[deck.size() - 1])
	set("theme_override_constants/v_separation", get_compact_separation())


func _deck_removed_card(card_index: int) -> void:
	print(get_parent().name)
	get_child(card_index).queue_free()


func _deck_moved_card(first_index: int, second_index: int) -> void:
	move_child(get_child(first_index), second_index)
	var i := 0
	for child in get_children():
		child.load_card(deck.cards[i])
		i += 1

func _deck_card_flags_modified(idx: int, new_flags: int) -> void:
	get_child(idx).display_flags(new_flags)
