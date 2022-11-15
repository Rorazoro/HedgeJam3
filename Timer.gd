extends Control

onready var TimeLabel = get_node("%Time")
onready var Countdown = get_node("%Timer")
onready var AudioPlay = get_node("%AudioStreamPlayer")

var time_left
var time

var tones = [preload("res://Assets/Sounds/mixkit-marimba-ringtone-1359.wav"),
					preload("res://Assets/Sounds/mixkit-marimba-waiting-ringtone-1360.wav"),
					preload("res://Assets/Sounds/mixkit-waiting-ringtone-1354.wav")]
# Called when the node enters the scene tree for the first time.
func _ready():
	#Pick random ringtone
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index = rng.randi_range(0, tones.size()) - 1
	print(index)
	AudioPlay.set_stream(tones[index])
	AudioPlay.play()
	
	#Setup coundown timer
	var timer = GameManager.timeLimit
	if GameManager.extendedTimer:
		timer = timer * 2
	
	Countdown.start(timer)
	var time = calc_time_label(timer)
	TimeLabel.text = time
	
	GameManager.timer = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Countdown.is_stopped():
		time_left = Countdown.time_left
		time = calc_time_label(time_left)
		TimeLabel.bbcode_text = time
	else:
		TimeLabel.bbcode_text = "[color=#e58f90]" + time + "[/color]"
	

func calc_time_label(seconds):
	var mins_left = int(seconds / 60.0)
	var sec_left = int(fmod(seconds, 60.0))
	var final_str = str(mins_left) + ":" + str(sec_left)
	return final_str


func _on_AudioStreamPlayer_finished():
	if !Countdown.is_stopped():
		var index = randi() % 3
		AudioPlay.set_stream(tones[index])
		AudioPlay.play()
	else: 
		AudioPlay.play()

func play_game_over_audio():
	var game_over = preload("res://Assets/Sounds/game_over.mp3")
	AudioPlay.set_stream(game_over)
	AudioPlay.play()

func _on_Timer_timeout():
	GameManager.on_lose()
