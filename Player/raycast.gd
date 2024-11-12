extends RayCast3D

@onready var interactlabel = $Label
#@onready var llavesINV = $LlavesPng

func _process(_delta):
	if is_colliding():
		var hit_obj = get_collider()
		if hit_obj and hit_obj.has_method("interact"):
			if Input.is_action_just_pressed("Interactuar"):
				hit_obj.interact()
			interactlabel.show()  # Mostrar la etiqueta cuando hay colisión y es interactuable
		else:
			interactlabel.hide()  # Ocultar la etiqueta si no hay un objeto interactuable
	else:
		interactlabel.hide()  # Ocultar la etiqueta cuando no hay colisión
#Inventario:
	if global.llavesCasa == true:
		$InventarioCuadricula/LlavesPng.show()
