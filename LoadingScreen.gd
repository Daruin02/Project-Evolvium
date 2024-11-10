extends Control

var progress = []
var sceneName
var sceneLoadStatus = 0

func _ready():
	sceneName = "res://Mundo/mundo.tscn"
	ResourceLoader.load_threaded_request(sceneName)
func _process(delta):
	sceneLoadStatus=ResourceLoader.load_threaded_get_status(sceneName,progress)
	$countDown.text = str(floor(progress[0]*100))+"%"
	if sceneLoadStatus == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
