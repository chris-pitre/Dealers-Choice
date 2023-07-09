class_name CardSelector extends Control


signal selected_card(card: Card)


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


func _on_card_add_button_pressed() -> void:
	print("Card 1 selected.")


func _on_card_add_button_2_pressed() -> void:
	print("Card 2 selected.")


func _on_card_add_button_3_pressed() -> void:
	print("Card 3 selected.")
