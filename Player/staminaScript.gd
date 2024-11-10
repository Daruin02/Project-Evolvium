extends Control
@onready var stamina = $TextureProgressBar
var jugador = preload("res://Player/jugador.gd")
var can_regen = false
var time_to_wait = 1
var s_timer = 0
var can_start_stimer = true

func _ready():
	stamina.value = stamina.max_value
func _process(delta):
	if stamina.value == 0:
		global.can_jump = false
		global.can_run = false
		time_to_wait = 4.3
	if not global.isCrouching and global.can_run == true and global.isRunning:
		stamina.value -= 1
		can_regen = false
		s_timer = 0
	if Input.is_action_just_pressed("ui_accept") and global.can_jump == true:
		stamina.value -= 35
		can_regen = false
		time_to_wait = 2
		s_timer = 0
	if can_regen == false and stamina.value != 500:
		can_start_stimer = true
		if can_start_stimer:
			s_timer += delta
			if s_timer >= time_to_wait:
				can_regen = true
				can_start_stimer = false
				s_timer = 0
	if stamina.value > 25:
		global.can_jump = true
		global.can_run = true
	if stamina.value == 500:
		can_regen = false
		time_to_wait = 1
	if can_regen == true:
		stamina.value += 2
		can_start_stimer = false
		s_timer = 0
