extends Control

func _ready():
	if GameManager.firstPlay:
		$MainMenu/ExtrasButton.visible = true

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/MainScene.tscn")

func _on_ExtrasButton_pressed():
	$MainMenu.visible = false
	$ExtrasMenu.visible = true

func _on_CreditsButton_pressed():
	$MainMenu.visible = false
	$CreditsMenu.visible = true

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsBackButton_pressed():
	$CreditsMenu.visible = false
	$MainMenu.visible = true

func _on_ExtrasBackButton_pressed():
	$ExtrasMenu.visible = false
	$MainMenu.visible = true

func _on_ExtendedTimerButton_toggled(button_pressed):
	GameManager.extendedTimer = button_pressed

func _on_FastEnemiesButton_toggled(button_pressed):
	GameManager.fastEnemies = button_pressed
