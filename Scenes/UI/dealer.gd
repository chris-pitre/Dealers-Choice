extends VBoxContainer


signal dealer_shuffle
signal dealer_swap_back
signal dealer_mark


func _on_shuffle_pressed() -> void:
	dealer_shuffle.emit()


func _on_swap_back_pressed() -> void:
	dealer_swap_back.emit()


func _on_mark_pressed() -> void:
	dealer_mark.emit()
