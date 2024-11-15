extends Area3D  # Usa Area2D si es en 2D

@export var destination: Vector3  # Especifica la posición de destino en el editor
@onready var jugador = get_node_or_null("res://Player/jugador.tscn")
 # Ajusta la ruta al nodo del jugador

func _on_area_body_entered(body):
	if body.name == "jugador":
		print("Jugador detectado, teletransportando...")
		body.global_transform.origin = destination

func teletransportar_jugador():
	if jugador:
		jugador.global_transform.origin = destination
