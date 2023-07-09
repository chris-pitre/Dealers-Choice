class_name CardSelector extends Control


signal selected_card(card: Card)

@onready var card_button = preload("res://Scenes/UI/card_add_button.tscn")

@export var card_buttons: HBoxContainer


func show_cards() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	await tween.tween_property(self, "position", Vector2(0, 0), 0.6).finished

func hide_cards() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	await tween.tween_property(self, "position", Vector2(0, 360), 0.6).finished


func get_random_cards() -> void:
	for card_button in card_buttons.get_children():
		card_button.queue_free()
		
	for i in range(3):
		var new_card_button = card_button.instantiate()
		new_card_button.set_card(GeneratorSingleton.get_random_card())
		match i:
			0:
				new_card_button.pressed.connect(_on_card_add_button_0_pressed)
			1:
				new_card_button.pressed.connect(_on_card_add_button_1_pressed)
			2:
				new_card_button.pressed.connect(_on_card_add_button_2_pressed)
		card_buttons.add_child(new_card_button)

func _on_card_add_button_0_pressed() -> void:
	select_card(0)

func _on_card_add_button_1_pressed() -> void:
	select_card(1)
	
func _on_card_add_button_2_pressed() -> void:
	select_card(2)

func select_card(idx: int) -> void:
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
	
	
