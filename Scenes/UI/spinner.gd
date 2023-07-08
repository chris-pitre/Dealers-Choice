extends TextureRect

var spin = 0.0
var current_actor: BattleActor

func change_spinner(actor: BattleActor) -> void:
	if actor.is_player:
		spin = 0
	else:
		spin = PI
	flip()
	
func _on_battle_manager_turn_changed(actor) -> void:
	if actor.is_player:
		spin = 0
	else:
		spin = PI
	flip()

func flip() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", spin, 0.2)
