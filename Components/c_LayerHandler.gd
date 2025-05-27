extends Node2D
class_name c_LayerHandler

@export var base_object : CollisionObject2D
@export var additional_objects : Array[CollisionObject2D]
@export var initial_room_layer : int = 1

@export var scale_depth : bool = true

signal _request_reparent
signal _change_layer

#
var IgnoreLayerOnCreation : bool = false

func _ready():
	if base_object == null:
		base_object = get_parent()
	base_object.add_to_group("Layerable")

func InitializeObjectLayers():
	UpdateAllObjectLayers()

#Gets/Sets current room layer through byte of its collision layer/mask flags
func GetLayer(object : CollisionObject2D = base_object) -> int :
	return floor(log(object.collision_layer)/log(256)) + 1

#Updates layer and signals request to reparent owner if layer changes
func ChangeLayer(layer: int):
	var startingLayer = GetLayer()
	UpdateAllObjectLayers(layer)
	if GetLayer() != startingLayer:
		_request_reparent.emit(base_object)

#Sets layers of all managed objects at once
func UpdateAllObjectLayers(layer : int = initial_room_layer):
	if layer > 0 && layer < 4:
		SetLayerAndMask(base_object, layer)
		for obj : CollisionObject2D in additional_objects:
			SetLayerAndMask(obj, layer)

func SetLayerAndMask(object : CollisionObject2D, value : int) -> void:
		if (value > 0 && value <= 3):
			var dif : int = value - GetLayer(object)
			var left : bool = dif > 0
			dif = abs(dif) * 8
			object.collision_layer = object.collision_layer << dif if left else object.collision_layer >> dif
			object.collision_mask = object.collision_mask << dif if left else object.collision_mask >> dif
