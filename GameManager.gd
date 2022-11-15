extends Node

var current_scene = null
var phonebooths = null
var player : Player = null
var timeLimit : float = 120.0
var timer = null
var firstPlay = false

var extendedTimer = false
var fastEnemies = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func disable_all_ai():
	if phonebooths:
		for	pb in phonebooths:
			pb.startAI = false

func disable_player_controls():
	player.inputEnabled = false

func show_win_panel():
	player.find_node("Win").visible = true
	
func show_lose_panel():
	player.find_node("Lose").visible = true

func stop_timer():
	timer.Countdown.stop()

func on_win():
	print("YOU WIN!!!")
	disable_all_ai()
	disable_player_controls()
	show_win_panel()
	stop_timer()
	timer.play_game_over_audio()
	if !firstPlay:
		firstPlay = true

func on_lose():
	print("YOU LOSE!!!")
	disable_all_ai()
	disable_player_controls()
	show_lose_panel()
	stop_timer()
	timer.play_game_over_audio()
	if !firstPlay:
		firstPlay = true
