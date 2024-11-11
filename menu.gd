extends Control

func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/loadingScreen.tscn")

func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")

func _on_salir_pressed():
	get_tree().quit()
