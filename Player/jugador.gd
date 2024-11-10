extends CharacterBody3D

#VARIABLES DEL NODO
var SPEED = 3.2
var JUMP_VELOCITY = 4.5
var crouchingSpeed = 1.6
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var noclip = false  # Variable para activar/desactivar el modo noclip
var novision = false 
var original_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")  # Guarda la gravedad original

#VARIABLES DE NODOS
@onready var footSteps = $neck/audio/footsteps
@onready var jumpStep = $neck/audio/jumpstep
@onready var neck := get_node("neck")
@onready var camera := get_node("neck/Primerpersona")
@onready var luzCerca = $neck/Primerpersona/Luces/lamparaCerca
@onready var luzLejana =$neck/Primerpersona/Luces/lamparaLejos
@onready var luzProfunda = $neck/Primerpersona/Luces/lamparaMasLejos
@onready var transition = $HUD/Transition
@onready var startMsg = $Label
@onready var cabalho = $"../cabalho/NavigationAgent3D"
@export var swim_up_speed := 10.0
@onready var moto = $neck/randomShit/moto
@onready var pico = $neck/randomShit/pico
@onready var hud = $HUD
@onready var rShit = $neck/randomShit
@onready var linterna = $"neck/Primerpersona/Luces/linternaEncendida"
@onready var linternaOFF = $"neck/Primerpersona/Luces/linternaApagada"


func _process(_delta): #NOCLIP
	# Alternar modo noclip al presionar "V"
	if Input.is_action_just_pressed("noclip"):
		noclip = !noclip
		if noclip==true:
			moto.show()
			pico.show()
			set_collision_layer(0)  # Deshabilitar colisiones
			set_collision_mask(0)
			velocity = Vector3.ZERO  # Detener cualquier movimiento en curso
			gravity = 0  # Deshabilitar gravedad
			SPEED = SPEED*8
		else:
			if noclip==false:
				moto.hide()
				pico.hide()
				set_collision_layer(1)  # Habilitar colisiones
				set_collision_mask(1)
				gravity = original_gravity  # Restaurar gravedad
				SPEED = 3.2
	# Movimiento vertical en modo noclip
	if noclip:
		if Input.is_action_pressed("elevate"):  # Asegúrate de mapear "elevate" a la tecla "E" en el Input Map
			velocity.y = SPEED*1.8  # Ajusta SPEED al valor deseado para elevarse
		elif Input.is_action_pressed("descend"):  # Asegúrate de mapear "descend" a la tecla "Q"
			velocity.y = -SPEED*1.8  # Ajusta SPEED para bajar
		else:
				velocity.y = 0  # Detener movimiento vertical cuando no se presionan E o Q

func _input(event): #F1 & LANTERN HIDE / SHOW
	if event.is_action_pressed("F1"):
		novision = !novision
		if novision:
			hud.hide()
			linterna.hide()
			linternaOFF.hide()
			$neck/Primerpersona/RayCast3D/InventarioCuadricula.hide()
		else:
			$neck/Primerpersona/RayCast3D/InventarioCuadricula.show()
			hud.show()
			linterna.show()

	if Input.is_action_just_pressed("clicizq") or Input.is_action_just_pressed("clicder"):
		startMsg.hide()
	if Input.is_action_just_pressed("clicizq") and global.lampoff == false:
		linterna.hide()
		linternaOFF.show()
		luzCerca.hide()
		luzLejana.hide()
		luzProfunda.hide()
		global.lampoff = true
	elif Input.is_action_just_pressed("clicizq") and global.lampoff == true:
		global.lampoff = false
		linterna.show()
		linternaOFF.hide()
		luzCerca.show()
		luzLejana.show()
		luzProfunda.show()
	if Input.is_action_pressed("correr") and get_input_vector().length() > 0:
		global.isRunning = true
	else:
		global.isRunning = false
func get_input_vector() -> Vector2: #WASD
	return Input.get_vector("izquierda", "derecha", "adelante", "atras")
func _unhandled_input(event: InputEvent) -> void: #MOUSE CAMERA
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.003)
			camera.rotate_x(-event.relative.y * 0.003)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
func _play_footsteps_audio(): #FOOT STEP AUDIO
	footSteps.pitch_scale = randf_range(.6, 1)
	footSteps.play()
func _physics_process(delta: float) -> void: #CAN_JUMP CAN_RUN IS ON FLOOR ?
	if not is_on_floor():
		global.can_jump = false
		velocity.y -= gravity * delta
	if global.isCrouching == true:
		global.can_run	= false

	var input_dir := Input.get_vector("izquierda", "derecha", "adelante", "atras")
	var direction = ((neck as Node3D).transform.basis.rotated(Vector3.UP, rotation.y) * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if global.can_run == true && Input.is_action_pressed("correr"):
			velocity.x *= 1.8
			velocity.z *= 1.8
			if not is_on_floor():
				velocity.x *= 1.7
				velocity.z *= 1.7
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if is_on_floor() and not global.isCrouching and input_dir.length() > 0:
		if global.isRunning and global.can_run == true:
			$neck/AnimationPlayer.play("headbobrunning")
		else:
			$neck/AnimationPlayer.play("headbob")
	else:
		$neck/AnimationPlayer.stop()

	if Input.is_action_pressed("agacharse"):
		global.isCrouching = true
		$neck.position.y = -0.1
	else:
		global.isCrouching = false
		$neck.position.y = 0.5

	if global.can_jump == true and is_on_floor() && Input.is_action_just_pressed("ui_accept"):
		global.isJumping = true 
		velocity.y = JUMP_VELOCITY
		jumpStep.pitch_scale = randf_range(.6, 1)
		jumpStep.play()
	if global.isCrouching == true:
		velocity.x *= 0.7
		velocity.z *= 0.7
		if global.isCrouching == false:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
