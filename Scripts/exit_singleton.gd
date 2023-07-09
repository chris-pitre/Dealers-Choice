extends Node

func _input(event):
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
