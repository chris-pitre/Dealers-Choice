class_name Dealer extends VBoxContainer


signal dealer_dealt(card: Card)


var points: int = 20 : set = _set_points

@export var top_card: CardDisplay
@export var peek_card: CardDisplay
@export var num_cards_left_label: Label
@export var action_description: Label
@export var point_label: Label

var peeked = false
var battle: Battle

@onready var deck: Deck = Deck.new(): set = _set_deck

func _set_points(new_points: int):
	points = new_points
	point_label.text = str(points)

func do_peek_card() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(peek_card, "position", Vector2(72, 0), 0.5)
	peek_card.load_card(deck.cards[1])
	$PeekTimer.start()

func _on_shuffle_pressed() -> void:
	if points >= 2:
		points -= 2
		deck.shuffle_deck()
		top_card.load_card(deck.cards[0])

func _on_swap_back_pressed() -> void:
	if points >= 2:
		points -= 2
		deck.move_card(0, deck.size() - 1)
		top_card.load_card(deck.cards[0])

func _on_mark_pressed() -> void: # This is actually a peeking action. Don't believe the lies
		if peeked:
			do_peek_card()
		else:
			if points >= 6:
				do_peek_card()
				points -= 6
				peeked = true

func _on_deal_button_pressed() -> void:
	AudioSingleton.play_sfx(load("res://Assets/SFX/card.wav"))
	dealer_dealt.emit(deck.remove_card(0))
	if deck.cards.size() > 0:
		top_card.load_card(deck.cards[0])
	num_cards_left_label.text = "Num cards left: %d" % deck.size()
	peeked = false
	
func _on_discard_pressed() -> void:
	if points >= 5 and deck.size() > 1:
		points -= 5
		var card = deck.remove_top_card()
		Battle.discard.add_card(card)
		top_card.load_card(deck.cards[0])

func _set_deck(_deck: Deck) -> void:
	deck = _deck
	top_card.load_card(deck.cards[0])
	deck.num_cards_changed.connect(_deck_num_cards_changed)

func _deck_num_cards_changed(amt: int) -> void:
	num_cards_left_label.text = "Num cards left: %d" % amt

func _on_shuffle_mouse_entered() -> void:
	action_description.text = "Shuffles the deck. (2 points)"

func _on_shuffle_mouse_exited() -> void:
	action_description.text = ""

func _on_swap_back_mouse_entered() -> void:
	action_description.text = "Swaps the front and back card. (2 points)"

func _on_swap_back_mouse_exited() -> void:
	action_description.text = ""

func _on_mark_mouse_entered() -> void:
	action_description.text = "Allows you to look at the card below the top card. (6 points)"

func _on_mark_mouse_exited() -> void:
	action_description.text = ""

func _on_discard_mouse_entered() -> void:
	action_description.text = "Discards the top card of the deck. (5 points)"

func _on_discard_mouse_exited():
	action_description.text = ""

func _on_peek_timer_timeout() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(peek_card, "position", Vector2(0, 0), 0.5)
