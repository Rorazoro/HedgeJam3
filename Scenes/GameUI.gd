extends Control

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_PlayAgainButton_pressed():
	get_tree().reload_current_scene()
