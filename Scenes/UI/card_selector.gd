class_name CardSelector extends Control


signal selected_card(card: Card)


@export var card_buttons: HBoxContainer


func _ready() -> void:
	for card_button in card_buttons.get_children():
		card_button.pressed.connect(_on_card_add_button_pressed)


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
