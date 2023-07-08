class_name GameCard
extends Control

@export var action_component: ActionComponent
@export var card_template: CardTemplate

static var card_index: int

var anim
var card_sprite 
var card_name
var card_description

func load_card(template: CardTemplate):
	anim = $AnimationPlayer
	card_sprite = $CardSprite
	card_name = $CardSprite/CardName
	card_description = $CardSprite/CardDescription
	
	card_sprite.texture = template.texture
	card_name.text = template.name
	card_description.text = template.description % template.numbers
	action_component.action = template.action
	if template.numbers.size() >= 1:
		action_component.value = template.numbers[0]

func do_action(target):
	action_component.do_action(target)
