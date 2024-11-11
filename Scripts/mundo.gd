extends Node3D

@onready var jugador = $jugador
@onready var pauseMenu = $pauseMenu
var paused = false

func _ready():
	jugador = get_node("jugador")
	pauseMenu = get_node_or_null("pauseMenu")  # Usa get_node_or_null para evitar errores si no encuentra el nodo

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and pauseMenu:
		pauseMenu.visible = not pauseMenu.visible
		paused = not paused
		Engine.time_scale = 0 if paused else 1
