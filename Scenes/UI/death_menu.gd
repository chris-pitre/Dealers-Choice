extends Control

@onready var won_text = $GreenPanel/VBoxContainer/Won.text
@onready var score_text = $GreenPanel/VBoxContainer/Score.text 

func update_score():
	$GreenPanel/VBoxContainer/Won.text = "Matches Won: "+str(Main.matches_won)
	$GreenPanel/VBoxContainer/Score.text  = "Total Score: "+str(Main.score)

func _on_quit_pressed():
	get_tree().quit()
