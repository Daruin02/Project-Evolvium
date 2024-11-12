extends Node3D

@onready var jugador = get_node_or_null("jugador")
@onready var pauseMenu = get_node_or_null("pauseMenu")
var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and pauseMenu:
		pauseMenu.visible = not pauseMenu.visible
		paused = not paused
		Engine.time_scale = 0 if paused else 1
