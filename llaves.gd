extends Node3D

var interacting = false

func interact():
	if interacting:
		return
	interacting = true
	$Label.show()
	$Timer.start()
	$".".hide()
	$AudioStreamPlayer3D.play()
	global.llavesCasa = true

func _on_timer_timeout():
	$Label.hide()
	interacting = false
	$"..".queue_free()
