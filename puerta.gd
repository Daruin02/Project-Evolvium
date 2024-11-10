extends StaticBody3D

var toggle = false
var is_animating = false
@export var doorAnimation: AnimationPlayer  # Asegúrate de que esto esté asignado
@onready var door_sound = $door_sound       # Referencia al sonido de apertura
@onready var locked_door = $doorClosed
var is_locked_animating = false

func interact():
	if global.llavesCasa == true:
		if doorAnimation and not is_animating:  # Solo interactúa si no está en animación
			toggle = !toggle
			is_animating = true  # Marca que la animación ha comenzado
			if toggle:
				doorAnimation.play("puerta")  # Reproduce la animación de apertura
				door_sound.play()
			else:
				doorAnimation.play("closePuerta")  # Reproduce la animación de cierre
				door_sound.play()
	else:
		if not is_locked_animating:  # Solo ejecuta si no está en la animación "puertaNoabre"
			is_locked_animating = true  # Marca el inicio de la animación
			$LlavesNo.show()
			$Timer2.start()
			doorAnimation.play("puertaNoabre")
			locked_door.play()
			locked_door.pitch_scale = randf_range(.8, 1.2)
			await doorAnimation.animation_finished  # Espera a que termine la animación
			is_locked_animating = false  # Permite la interacción nuevamente

func _on_animation_finished(anim_name):
	is_animating = false  # La animación ha terminado, se puede volver a interactuar

func _on_timer_timeout():
	$LlavesNo.hide()


func _on_timer_2_timeout() -> void:
	pass # Replace with function body.
