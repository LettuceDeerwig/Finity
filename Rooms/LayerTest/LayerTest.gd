extends Node2D

@export var layer_1 : RoomLayer
@export var layer_2 : RoomLayer
@export var layer_3 : RoomLayer

var RoomLayers : Dictionary

func _ready():
	InitializeRoomLayers()
	AssignAllObjectLayers()

func InitializeRoomLayers():
	layer_1.LayerNumber = 1
	layer_2.LayerNumber = 2
	layer_3.LayerNumber = 3
	RoomLayers = {1: layer_1, 2: layer_2, 3: layer_3}

#initialize layerable objects
func AssignAllObjectLayers():
	var layerables : Array[Node] = get_tree().get_nodes_in_group("Layerables")
	for lay in layerables:
		if lay is CollisionObject2D:
			for key in RoomLayers:
				var rl : RoomLayer = RoomLayers[key]
				if rl.is_ancestor_of(lay):
					lay.Layer.intended_layer = rl.LayerNumber
					break
			if !lay.Layer.is_connected("_request_layer_change", ChangeObjectLayer):
				lay.Layer.connect("_request_layer_change", ChangeObjectLayer)
			if "SetCurrentLayer" in lay:
				lay.SetCurrentLayer(lay.Layer.intended_layer)
			else:
				ChangeObjectLayer(lay, lay.Layer.intended_layer)

func ChangeObjectLayer(obj : CollisionObject2D, layerNumber : int):
	if "Layer" in obj && obj.Layer is c_LayerHandler:
		var toRoomLayer : RoomLayer = RoomLayers[layerNumber]
		if toRoomLayer != null:
			obj.Layer.MoveObjectToRoomLayer(obj, toRoomLayer.LayerNumber, toRoomLayer.depth_scale, toRoomLayer.Layerables)
