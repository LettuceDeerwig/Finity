extends StaticBody2D

@export var Layer : c_LayerHandler

func _ready():
	self.add_to_group("Layerables")
