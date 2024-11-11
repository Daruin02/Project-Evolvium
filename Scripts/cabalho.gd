extends CharacterBody3D

# speed vars
@export var speed = 2
@export var accel = 1

# the vars which make you do the thing where you do the thing
@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var target: CharacterBody3D = $"../jugador"

func _physics_process(delta):
	
	var direction = Vector3()
	
	nav.target_position = target.global_position # this one needs the @onready vars we defined earlier
	
	direction = nav.get_next_path_position() - global_position # and so does this
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	

	move_and_slide()
