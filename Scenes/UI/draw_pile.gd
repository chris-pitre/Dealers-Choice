extends Button


var panel_toggled = false: set = _set_panel_toggled


func _on_mouse_entered() -> void:
	$Description.show()


func _on_mouse_exited() -> void:
	$Description.hide()


func _on_pressed() -> void:
	panel_toggled = not panel_toggled


func _set_panel_toggled(x) -> void:
	panel_toggled = x
	$GreenPanel.visible = x
	$Description.text = "Hide draw pile" if x else "Show draw pile"
