extends StaticBody2D
class_name Floor

@export var Layer : c_LayerHandler

func _ready():
	self.add_to_group("Layerables")
