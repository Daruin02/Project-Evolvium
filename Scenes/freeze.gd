extends StaticBody3D

var interacting = false
var is_open = false

func interact():
	if interacting:
		return

	interacting = true

	# Si el refrigerador está cerrado, se abre; si está abierto, se cierra
	if is_open:
		$"../../Freezer".play_backwards("freezer")
	else:
		$"../../Freezer".play("freezer")

	# Cambia el estado de apertura
	is_open = not is_open

func _on_animation_finished(anim_name):
	# Asegúrate de que la animación terminada sea la del refrigerador
	if anim_name == "freezer":
		interacting = false  # Permitir otra interacción después de terminar la animación
