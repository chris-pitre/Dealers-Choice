extends Node

var test_card_scene: PackedScene = preload("res://Scenes/Cards/test_card.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var test_card = test_card_scene.instantiate()
		test_card.name = "Card"+str($Deck.num_cards)
		$Deck.add_card(test_card)
	if Input.is_action_just_pressed("ui_cancel"):
		$Deck.delete_card($Deck.get_child(0))
	if Input.is_action_just_pressed("ui_up"):
		$Deck.shuffle_deck()
	if Input.is_action_just_pressed("ui_down"):
		var top_card = $Deck.card_indexes[0]
		$Deck.play_card(top_card)
	
