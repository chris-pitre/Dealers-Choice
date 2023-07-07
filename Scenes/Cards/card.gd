class_name Card
extends Node2D

@export var card_sprite: CompressedTexture2D
@export var action_component: ActionComponent

func _ready():
	$Sprite2D.texture = card_sprite
	
func do_action(target):
	action_component.do_action(target)
