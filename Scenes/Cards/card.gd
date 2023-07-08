class_name GameCard
extends Control

@export var action_component: ActionComponent
@export var card_template: CardTemplate

static var card_index: int

@onready var anim = $AnimationPlayer
@onready var card_sprite = $CardSprite
@onready var card_name = $CardSprite/CardName
@onready var card_description = $CardSprite/CardDescription

func _ready():
	pass

func load_card(template: CardTemplate):
	card_sprite.texture = template.texture
	card_name.text = template.name
	card_description.text = template.description % template.numbers

func do_action(target):
	action_component.do_action(target)
