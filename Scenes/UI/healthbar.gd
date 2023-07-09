class_name Healthbar extends Control

var health: int = 30: set = _set_health
var max_health: int = 30: set = _set_max_health

@export var health_progress: TextureProgressBar
@export var health_damage: TextureProgressBar
@export var health_heal: TextureProgressBar
@export var damage_indication_timer: Timer
@export var heal_indication_timer: Timer

func _set_health(x):
	if health > x:
		health_damage.value = health
		health_progress.value = x
		health_heal.hide()
		damage_indication_timer.start()
	else:
		health_heal.value = x
		health_heal.show()
		heal_indication_timer.start()
	health = x
	$Amount.text = "%d/%d" % [health, max_health]

func _set_max_health(x):
	max_health = x
	health_progress.max_value = x
	health_damage.max_value = x
	health_heal.max_value = x
	$Amount.text = "%d/%d" % [health, max_health]

func _on_heal_indication_timeout() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(health_progress, "value", health, 0.5)
	tween.play()
	await tween.finished

func _on_damage_indication_timeout() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(health_damage, "value", health, 0.5)
	tween.play()
	await tween.finished
