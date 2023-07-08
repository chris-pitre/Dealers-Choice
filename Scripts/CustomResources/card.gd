class_name Card extends Resource

enum Action{Attack, Defend, Rush, Heal}

@export var name: String = "TestCard"
@export_multiline var description: String = "This is a description."
@export var sprite: Texture
@export var numbers: Array[int] = []
@export var action: Action 
