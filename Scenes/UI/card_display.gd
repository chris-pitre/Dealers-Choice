class_name CardDisplay extends Control


var card: Card
var flipped: bool = false: set = _set_flipped
var flipping = false
var velocity: Vector2 = Vector2.ZERO
var accel: Vector2 = Vector2.ZERO
var angular_velocity: float = 0.0


@export var name_label: Label
@export var sprite: TextureRect
@export var description_label: Label
@export var card_back: TextureRect
@export var hoverable: bool = true
@export var hover_direction: Vector2 = Vector2.RIGHT * 64


func _physics_process(delta: float) -> void:
	global_position += velocity * delta
	rotation += angular_velocity * delta
	velocity += accel * delta


func load_card(card: Card) -> void:
	name_label.text = card.name
	sprite.texture = card.sprite
	description_label.text = card.description % card.numbers


func show_sprite() -> void:
	sprite.modulate = Color.WHITE


func hide_sprite() -> void:
	sprite.modulate = Color.TRANSPARENT


func anim_add_child(to: Control) -> void:
	hide()
	
	var new_display = duplicate()
	to.add_child(new_display)
	new_display.hide_sprite()
	print(new_display.global_position)
	
	var move_display = duplicate()
	get_node("root/Main").add_child(move_display)
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(move_display, "global_position", new_display.global_position, 0.5)
	
	await tween.finished
	new_display.show_sprite()
	queue_free()


func display_flags(flags: int) -> void:
	if flags & Card.CardFlags.Flipped:
		card_back.show()
	else:
		card_back.hide()
	if flags & Card.CardFlags.Marked:
		pass

func _set_flipped(x) -> void:
	if x != flipped:
		if not flipping:
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_QUAD)
			tween.tween_property(sprite, "scale", Vector2(0, 1), 0.2)
			await tween.finished
			if not x:
				card_back.show()
			else:
				card_back.hide()
			tween.tween_property(sprite, "scale", Vector2(1, 1), 0.2)
			flipped = not flipped
	flipped = x

func _on_mouse_entered() -> void:
	if hoverable:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(sprite, "position", hover_direction, 0.3)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position", Vector2.ZERO, 0.3)
