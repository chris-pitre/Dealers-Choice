extends Node

func _ready():
	var p = AudioStreamPlayer.new()
	add_child(p)
	p.bus = "SFX"
	p.stream = load("res://Assets/Music/song.wav")
	p.play()
	

func play_sfx(stream: AudioStream, db: int = 0) -> void:
	var p = AudioStreamPlayer.new()
	add_child(p)
	p.bus = "SFX"
	p.volume_db = db
	p.stream = stream
	p.play()
	await p.finished
	p.queue_free()
