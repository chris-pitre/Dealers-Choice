extends TextureRect

var spin = 0.0

func _on_dealer_dealer_dealt(_card) -> void:
	flip()

func _on_battle_manager_turn_changed(actor) -> void:
	flip()

func flip() -> void:
	spin += PI
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", spin, 0.2)
