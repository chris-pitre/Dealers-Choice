class_name CardDisplay extends Control


var card


@export var name_label: Label
@export var sprite: TextureRect
@export var description_label: Label


func load_card(card: Card) -> void:
	name_label.text = card.name
	sprite.texture = card.sprite
	description_label.text = card.description % card.numbers


func show_sprite() -> void:
	sprite.show()


func hide_sprite() -> void:
	sprite.hide()


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
