class_name ActorDeckDisplay extends VFlowContainer

const CardDisplay = preload("res://Scenes/Cards/card_display.tscn")

var deck: Deck

@export var left_facing: bool = false

func _ready() -> void:
	var separation = floor((size.y - 96.0 * get_child_count()) / (get_child_count() - 1))
	add_theme_constant_override("v_separation", separation)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_SPACE and event.pressed:
			add_card_to_deck(load("res://Scripts/Cards/card_punch.tres"), Vector2(320, 180))

func set_separation(sep) -> void:
	if sep < 0:
		add_theme_constant_override("v_separation", sep)

func tween_separation(sep: int) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_method(
		set_separation,
		get("theme_override_constants/v_separation"),
		sep,
		0.5
	)
	await tween.finished

func get_compact_separation() -> int:
	return floor((size.y - 96.0 * get_child_count()) / (get_child_count() - 1))

func add_card_to_deck(card: CardTemplate, from: Vector2) -> void:
	var new_card = CardDisplay.instantiate()
	add_child(new_card)
	new_card.load_card(card)
	new_card.left_facing = left_facing
	new_card.hide()
	
	await tween_separation(get_compact_separation())
	
	new_card.show()
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_method(
		new_card.set_card_offset,
		from,
		Vector2.ZERO,
		0.5
	)
	
	await tween.finished

func clear_deck() -> void:
	await tween_separation(-97) #negative card size.y - 1
	for child in get_children():
		child.queue_free()
