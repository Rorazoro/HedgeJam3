extends Control

func _ready():
	pass # Replace with function body.

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/MainScene.tscn")

func _on_ExtrasButton_pressed():
	pass # Replace with function body.

func _on_CreditsButton_pressed():
	$MainMenu.visible = false
	$CreditsMenu.visible = true

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsBackButton_pressed():
	$CreditsMenu.visible = false
	$MainMenu.visible = true
