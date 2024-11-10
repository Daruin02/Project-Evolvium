extends Control

@onready var pauseMenu = $"."

func _ready():
	# Conectar señales de los botones
	var volume_button = $MarginContainer/VBoxContainer/Volume  # Obtener referencia al botón de volumen
	var back_button = $MarginContainer/VBoxContainer/Atras  # Obtener referencia al botón de atrás
	
	update_volume_button()  # Actualizar el texto del botón de volumen

func _on_Continue_pressed():
	pauseMenu.hide()
	Engine.time_scale = 1

func _on_Volume_pressed():
	# Alternar el estado de la música
	var is_music_on = not BgMusic.is_music_on  # Obtener el estado actual y alternar
	BgMusic.set_music_state(is_music_on)  # Llamar al método en MusicPlayer
	update_volume_button()  # Actualizar el texto del botón de volumen

func update_volume_button():
	# Cambiar el texto del botón según el estado de la música
	if BgMusic.is_music_on:
		$MarginContainer/VBoxContainer/Volume.text = "Music: Playing"
	else:
		$MarginContainer/VBoxContainer/Volume.text = "Music: Off"

func _on_Back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")  # Cambiar a la escena de menú principal
