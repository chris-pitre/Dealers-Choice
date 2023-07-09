class_name CardAddButton extends Button

var card

func set_card(_card: Card) -> void:
	card = _card
	$CardDisplay.load_card(card)
