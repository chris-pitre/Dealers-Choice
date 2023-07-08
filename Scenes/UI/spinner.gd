extends TextureRect

var spin = 0.0
var current_actor: BattleActor

func _on_dealer_dealer_dealt(_card) -> void:
	spin = 0 if spin == PI else PI
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
