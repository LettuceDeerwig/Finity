extends Node2D
class_name c_LayerHandler

@export var base_object : CollisionObject2D
#Layerable objects that depend on this object for layer management
@export var dependent_objects : Array[CollisionObject2D]
@export var initial_room_layer : int = 1
@export var scale_depth : bool = true

@onready var DependentsGroupName : String = "DependentLayerHandler_" + str(self.get_instance_id())
@onready var Scaler : c_PropertyScaler = $c_PropertyScaler

signal _request_layer_change
var IgnoreLayerOnCreation : bool = false

func _ready():
	if base_object == null:
		base_object = get_parent()
	self.add_to_group("BaseLayerHandler")
	#Create dependent layerables group
	for obj in dependent_objects:
		#verify object has layer handler
		if obj.Layer != null:
			#swap dependent from top-level layerables group to dependents group
			obj.Layer.add_to_group(DependentsGroupName)
			obj.Layer.remove_from_group("BaseLayerHandler")

#wrap queue free method
func Destroy() -> void:
	#clean up dependents group
	for nodes in get_tree().get_nodes_in_group(DependentsGroupName):
		nodes.remove_from_group(DependentsGroupName)
	queue_free()

#Gets/Sets current room layer through byte of its collision layer/mask flags
func GetLayer(object : CollisionObject2D = base_object) -> int :
	return floor(log(object.collision_layer)/log(256)) + 1

#Updates layer and signals request to reparent owner if layer changes
func ChangeLayer(layer: int = initial_room_layer):
	_request_layer_change.emit(self, layer)

func MoveToRoomLayer(roomLayer : RoomLayer):
	#reparent base object
	base_object.reparent(roomLayer)
	#change base object collision & mask
	SetLayerAndMask(base_object, roomLayer.LayerNumber)
	#apply room layer scale value to object(s)
	SetPropertiesScale(roomLayer.depth_scale)

func SetLayerAndMask(object : CollisionObject2D, value : int) -> void:
	var dif : int = value - GetLayer(object)
	var left : bool = dif > 0
	dif = abs(dif) * 8
	object.collision_layer = object.collision_layer << dif if left else object.collision_layer >> dif
	object.collision_mask = object.collision_mask << dif if left else object.collision_mask >> dif

func SetPropertiesScale(scale : float):
	Scaler.Scale = scale
