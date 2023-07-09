extends Node

func _input(event):
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		print(DeckCreatorSingleton.list_all_card_files())
