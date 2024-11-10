extends Control
@onready var energia = $TextureProgressBar2

func _ready():
	energia.value = energia.max_value
func _process(delta):
	if global.lampoff == false:
		energia = -1
