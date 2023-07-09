class_name CardSelector extends Control


signal selected_card(card: Card)


@export var card_buttons: HBoxContainer


func show_cards() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", Vector2(0, 0), 0.6)

func hide_cards() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", Vector2(0, 360), 0.6)


func get_random_cards() -> void:
	for card_button in card_buttons.get_children():
		card_button.set_card(GeneratorSingleton.get_random_card())


func _on_card_add_button_pressed(idx: int) -> void:
	print("Card %d selected." % idx)
	var indexes = [0, 1, 2]
	indexes.erase(idx)
	
	var favored_card = card_buttons.get_child(idx)
	var other_card1 = card_buttons.get_child(indexes[0])
	var other_card2 = card_buttons.get_child(indexes[1])
	#make favored card have special effect or something idk
	for button in card_buttons.get_children():
		button.disabled = true
	var random_float = randf()
	
	if random_float < 0.5:
		PlayerSingleton.add_card_to_deck(favored_card.card)
		selected_card.emit(favored_card.card)
	elif random_float < 0.75:
		PlayerSingleton.add_card_to_deck(other_card1.card)
		selected_card.emit(other_card1.card)
	else:
		PlayerSingleton.add_card_to_deck(other_card2.card)
		selected_card.emit(other_card2.card)
	
	
