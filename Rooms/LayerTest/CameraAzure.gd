extends Camera2D
class_name CameraAzure

@export var azure : Azure

func _process(delta):
	global_position = azure.global_position
