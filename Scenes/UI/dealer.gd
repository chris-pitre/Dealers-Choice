extends VBoxContainer


signal dealer_shuffle
signal dealer_swap_back
signal dealer_mark
signal dealer_dealt


var deck: Deck


func _on_shuffle_pressed() -> void:
	dealer_shuffle.emit()


func _on_swap_back_pressed() -> void:
	dealer_swap_back.emit()


func _on_mark_pressed() -> void:
	dealer_mark.emit()


func _on_deal_button_pressed() -> void:
	dealer_dealt.emit()
