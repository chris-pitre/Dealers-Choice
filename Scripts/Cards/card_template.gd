class_name CardTemplate
extends Resource

@export var name: String = "TestCard"
@export_multiline var description: String = "This is a test card. (loaded)"
@export var texture: Texture
@export var action: ActionData.ActionTypes
@export var numbers: Array[int] = []
@export var rare: bool = false
