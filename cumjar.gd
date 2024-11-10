extends Node3D

var interacting = false

func interact():
	if interacting:
		return
	
	interacting = true
	print("Nyahh~~")
	$Nyah.show()
	$Timer.start()
	$AudioStreamPlayer3D.play()
	$AudioStreamPlayer3D.pitch_scale = randf_range(.8, 1.2)

func _on_timer_timeout():
	$Nyah.hide()
	interacting = false
