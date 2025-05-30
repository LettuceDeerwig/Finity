extends CharacterBody2D
##Default class for objects that can change room layers
class_name Actor

@export var StateMachine : c_StateMachine
@export var Layer : c_LayerHandler
@export var Scaler : c_PropertyScaler

@export var DependentObjects : Array[CollisionObject2D]

var CurrentLayer: int :
	get:
		return Layer.GetLayer(self)
	set(value):
		SetCurrentLayer(value)

func _ready():
	_onActorReady()

func _onActorReady():
	self.add_to_group("Layerables")
	Layer.connect("_layer_change_complete", _on_layer_change_complete)
	for obj in DependentObjects:
		obj.remove_from_group("Layerables")

func SetCurrentLayer(layerNumber : int):
	Layer.ChangeLayer(self, layerNumber)

func _on_layer_change_complete(changedObject : CollisionObject2D):
	if changedObject == self:
		UpdateDependentObjectLayers()
	
func UpdateDependentObjectLayers():
	for obj : CollisionObject2D in DependentObjects:
		if "Layer" in obj && obj.Layer is c_LayerHandler:
			obj.Layer.MoveObjectToRoomLayer(obj, CurrentLayer, Scaler.Scale)
		else:
			Layer.MoveObjectToRoomLayer(obj, CurrentLayer, Scaler.Scale)
