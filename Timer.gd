extends Control

onready var TimeLabel = get_node("%Time")
onready var Countdown = get_node("%Timer")
onready var AudioPlay = get_node("%AudioStreamPlayer")

var tones = [preload("res://Assets/Sounds/mixkit-marimba-ringtone-1359.wav"),
					preload("res://Assets/Sounds/mixkit-marimba-waiting-ringtone-1360.wav"),
					preload("res://Assets/Sounds/mixkit-waiting-ringtone-1354.wav")]
# Called when the node enters the scene tree for the first time.
func _ready():
	#Pick random ringtone
	randomize()
	var index = randi() % 3
	print(index)
	AudioPlay.set_stream(tones[index])
	AudioPlay.play()
	
	#Setup coundown timer
	var timer = 15.0
	Countdown.start(timer)
	var time = calc_time_label(timer)
	TimeLabel.text = time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !Countdown.is_stopped():
		var time_left = Countdown.time_left
		var time = calc_time_label(time_left)
		TimeLabel.text = time
	else:
		TimeLabel.text = "DONE!"
	

func calc_time_label(seconds):
	var mins_left = int(seconds / 60.0)
	var sec_left = int(fmod(seconds, 60.0))
	var final_str = str(mins_left) + ":" + str(sec_left)
	return final_str


func _on_AudioStreamPlayer_finished():
	var index = randi() % 3
	AudioPlay.set_stream(tones[index])
	AudioPlay.play()


func _on_Timer_timeout():
	Countdown.stop()
	
