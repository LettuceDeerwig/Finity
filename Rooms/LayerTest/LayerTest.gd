extends Node2D

@export var layer_1 : RoomLayer
@export var layer_2 : RoomLayer
@export var layer_3 : RoomLayer

var RoomLayers : Dictionary

func _ready():
	InitializeRoomLayers()
	#initialize layerable objects
	var layerHandlers : Array[Node] = get_tree().get_nodes_in_group("BaseLayerHandler")
	for lh in layerHandlers:
		if lh is c_LayerHandler:
			for key in RoomLayers:
				var rl : RoomLayer = RoomLayers[key]
				if rl.is_ancestor_of(lh):
					lh.initial_room_layer = rl.LayerNumber
					break
			lh.connect("_request_layer_change", ChangeObjectLayer)
			ChangeObjectLayer(lh, lh.initial_room_layer)

func InitializeRoomLayers():
	layer_1.LayerNumber = 1
	layer_2.LayerNumber = 2
	layer_3.LayerNumber = 3
	RoomLayers = {1: layer_1, 2: layer_2, 3: layer_3}

func ChangeObjectLayer(lh : c_LayerHandler, layerNumber : int):
	var toRoomLayer : RoomLayer = RoomLayers[layerNumber]
	if toRoomLayer != null:
		lh.MoveToRoomLayer(toRoomLayer)
