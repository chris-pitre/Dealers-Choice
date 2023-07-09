class_name Main extends Node

@onready var battle_scene = preload("res://Scenes/UI/battle_scene.tscn")

func _ready() -> void:
	get_window().size = Vector2(640, 360) * 2

func _on_battle_new_battle() -> void:
	$CardSelector.get_random_cards()
	$CardSelector.show_cards()
	$Battle.queue_free()
	
func _on_card_selector_selected_card(card):
	var new_battle = await battle_scene.instantiate()
	add_child(new_battle)
