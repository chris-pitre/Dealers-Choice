class_name DiscardPile extends Button

var panel_toggled = false: set = _set_panel_toggled
var deck: Deck: set = _set_deck

func _on_mouse_entered() -> void:
	$Description.show()

func _on_mouse_exited() -> void:
	$Description.hide()

func _on_pressed() -> void:
	panel_toggled = not panel_toggled

func _set_panel_toggled(x) -> void:
	panel_toggled = x
	$GreenPanel.visible = x
	$Description.text = "Hide discard pile" if x else "Show discard pile"

func _set_deck(_deck: Deck) -> void:
	deck = _deck
	deck.added_card.connect(_deck_amount_changed)
	deck.removed_card.connect(_deck_removed_card)
	deck.combined.connect(_deck_amount_changed)
	deck.cleared.connect(_deck_amount_changed)

func _deck_amount_changed() -> void:
	$TextureRect/Amount.text = str(deck.size())

func _deck_removed_card(x) -> void:
	$TextureRect/Amount.text = str(deck.size())
