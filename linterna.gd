extends Node3D

var off = false

func interact():
	if Input.is_action_just_pressed("clicizq"):
		off = !off
		if off == true:
			print("Lámpara apagada")
