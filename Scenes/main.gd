class_name Main extends Node

@onready var battle_scene = preload("res://Scenes/UI/battle_scene.tscn")

@export var pause_menu: Control

static var matches_won = 0
static var score = 0

var active_battle

func _ready() -> void:
	active_battle = $Battle
	get_window().size = Vector2(640, 360) * 2

func _input(event):
	if event.is_action_pressed("quit_game"):
		pause_menu.visible = not pause_menu.visible

func _on_battle_new_battle() -> void:
	matches_won += 1
	$CardSelector.get_random_cards()
	await $CardSelector.show_cards()
	active_battle.queue_free()
	
func _on_card_selector_selected_card(card):
	var new_battle = await battle_scene.instantiate()
	add_child(new_battle)
	await $CardSelector.hide_cards()
	active_battle = new_battle
	active_battle.new_battle.connect(_on_battle_new_battle)
	active_battle.lost.connect(_on_battle_lost)
	move_child(active_battle, 0)

func _on_battle_lost():
	$DeathMenu.update_score()
	$DeathMenu.visible = true
	await $DeathMenu.show_menu()
	active_battle.queue_free()
