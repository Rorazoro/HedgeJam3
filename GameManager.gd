extends Node

var current_scene = null
var phonebooths = null
var player = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func disable_all_ai():
	if phonebooths:
		for	pb in phonebooths:
			pb.startAI = false

func disable_player_controls():
	player.inputEnabled = false

func on_win():
	print("YOU WIN!!!")
	disable_all_ai()
	disable_player_controls()

func on_lose():
	print("YOU LOSE!!!")
	disable_all_ai()
	disable_player_controls()
