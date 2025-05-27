extends Node2D

@export var Layer : c_LayerHandler
@export var NodesToScale : Array[Node2D]

func _process(delta: float) -> void:
	for node in NodesToScale:
		
