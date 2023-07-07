class_name GameCard
extends Control

@export var card_sprite: CompressedTexture2D
@export var action_component: ActionComponent

static var card_index: int

func _ready():
	$Sprite2D.texture = card_sprite
	$TextureRect.texture = card_sprite
	
func do_action(target):
	action_component.do_action(target)
