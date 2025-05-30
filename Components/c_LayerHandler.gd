extends Node2D
class_name c_LayerHandler

@export var intended_layer : int = 1
@export var scale_depth : bool = true
@export var Scaler : c_PropertyScaler

@onready var DependentsGroupName : String = "DependentLayerHandler_" + str(self.get_instance_id())

signal _request_layer_change
signal _layer_change_complete

var IgnoreLayerOnCreation : bool = false

func _ready():
	pass

#wrap queue free method
func Destroy() -> void:
	#clean up dependents group
	for nodes in get_tree().get_nodes_in_group(DependentsGroupName):
		nodes.remove_from_group(DependentsGroupName)
	queue_free()

#Gets/Sets current room layer through byte of its collision layer/mask flags
func GetLayer(object : CollisionObject2D) -> int :
	var calculatedLayer = floor(log(object.collision_layer)/log(256)) + 1
	return calculatedLayer if calculatedLayer > 0 else intended_layer

#Updates layer and signals request to reparent owner if layer changes
func ChangeLayer(obj: CollisionObject2D, layer: int = intended_layer):
	_request_layer_change.emit(obj, layer)

func MoveObjectToRoomLayer(object : CollisionObject2D, layerNumber : int, depthScale : float, newParent : Node2D = null):
	#verify this is top-level call
	if newParent != null:
		#reparent object to room layer's object container
		object.reparent(newParent)
	#change object collision & mask
	SetLayerAndMask(object, layerNumber)
	#apply room layer scale value to object(s)
	SetPropertiesScale(depthScale)
	#signal that layer has been changed
	_layer_change_complete.emit(object)

func SetLayerAndMask(object : CollisionObject2D, layerNumber : int) -> void:
	intended_layer = layerNumber
	var dif : int = layerNumber - GetLayer(object)
	var left : bool = dif > 0
	dif = abs(dif) * 8
	object.collision_layer = object.collision_layer << dif if left else object.collision_layer >> dif
	object.collision_mask = object.collision_mask << dif if left else object.collision_mask >> dif

func SetPropertiesScale(scaleValue : float):
	if Scaler != null:
		Scaler.Scale = scaleValue
