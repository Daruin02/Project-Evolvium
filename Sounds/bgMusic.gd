extends AudioStreamPlayer  # Asegúrate de que este script esté vinculado a un AudioStreamPlayer

var is_music_on = true  # Estado inicial de la música

func _ready():
	if not is_playing():
		play()  # Reproducir música al iniciar

func set_music_state(state: bool):
	is_music_on = state
	if is_music_on:
		play()  # Reproducir música
	else:
		stop()  # Detener música
