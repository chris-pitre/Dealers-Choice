class_name GameCard
extends Control

@export var action_component: ActionComponent
@export var hoverable: bool = true

var left_facing: bool = false
var hovered: bool = false
var offset: Vector2 = Vector2()

var card_offset: MarginContainer
var card_sprite: TextureRect
var card_name: Label
var card_description: Label

func _ready():
	pass

func load_card(template: CardTemplate):
	card_offset = $CardOffset
	card_sprite = $CardOffset/CardSprite
	card_name = $CardOffset/CardSprite/CardName
	card_description = $CardOffset/CardSprite/CardDescription
	
	card_sprite.texture = template.texture
	card_name.text = template.name
	card_description.text = template.description % template.numbers

func do_action(target):
	action_component.do_action(target)

func set_card_offset(_offset: Vector2) -> void:
	offset = _offset
	if _offset.x > 0:
		card_offset.add_theme_constant_override("margin_left", _offset.x)
		card_offset.add_theme_constant_override("margin_right", 0)
	else:
		card_offset.add_theme_constant_override("margin_left", -_offset.x)
		card_offset.add_theme_constant_override("margin_right", _offset.x)
	if _offset.y > 0:
		card_offset.add_theme_constant_override("margin_top", _offset.y)
		card_offset.add_theme_constant_override("margin_bottom", 0)
	else:
		card_offset.add_theme_constant_override("margin_top", -_offset.y)
		card_offset.add_theme_constant_override("margin_bottom", _offset.y)

func _on_mouse_entered() -> void:
	if hoverable and not hovered:
		hovered = true
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.tween_method(
			set_card_offset,
			offset,
			Vector2(64 * (-1 if left_facing else 1), 0),
			0.2
		)

func _on_mouse_exited() -> void:
	if hovered:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.tween_method(
			set_card_offset,
			offset,
			Vector2.ZERO,
			0.2
		)
		await tween.finished
		hovered = false
