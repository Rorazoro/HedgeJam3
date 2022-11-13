extends Node2D

func _ready():
	randomize_real_phonebooth()
	GameManager.player = get_node("Player")

func randomize_real_phonebooth():
	var phonebooths = get_tree().get_nodes_in_group("phonebooth")
	print(phonebooths.size())
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rand_index = rng.randi_range(1, phonebooths.size()) - 1
	print(rand_index)
	
	if phonebooths[rand_index]:
		phonebooths[rand_index].isReal = true
		print(phonebooths[rand_index])
		
	GameManager.phonebooths = phonebooths
