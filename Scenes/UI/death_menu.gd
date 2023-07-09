extends Control

@onready var won_text = $GreenPanel/VBoxContainer/Won.text
@onready var score_text = $GreenPanel/VBoxContainer/Score.text 

func update_score():
	$GreenPanel/VBoxContainer/Won.text = "Matches Won: "+str(Main.matches_won)
	$GreenPanel/VBoxContainer/Score.text  = "Total Score: "+str(Main.score)

func show_menu() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	await tween.tween_property(self, "position", Vector2(0, 0), 0.6).finished

func hide_menu() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	await tween.tween_property(self, "position", Vector2(0, 360), 0.6).finished

func _on_quit_pressed():
	get_tree().quit()
