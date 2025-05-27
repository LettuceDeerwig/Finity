extends Node2D

@export var layer_1 : RoomLayer
@export var layer_2 : RoomLayer
@export var layer_3 : RoomLayer

func _ready():
	var layerables : Array[Node] = get_tree().get_nodes_in_group("Layerable")
	for obj in layerables:
		if layer_1.is_ancestor_of(obj):
			obj.Layer.initial_room_layer = 1
		if layer_2.is_ancestor_of(obj):
			obj.Layer.initial_room_layer = 2
		if layer_3.is_ancestor_of(obj):
			obj.Layer.initial_room_layer = 3
		obj.Layer.connect("_request_reparent", ReparentObjectToNewLayer)
		PopulateLayerHandlerComponents(obj)
		obj.Layer.InitializeObjectLayers()			

func ReparentObjectToNewLayer(handlerOwner):
	if handlerOwner is CanvasItem:
		var newParent : Node2D
		match handlerOwner.CurrentLayer:
			3:
				newParent = layer_3
			2:
				newParent = layer_2
			_:
				newParent = layer_1
		handlerOwner.reparent(newParent)

#Populates any dependent components of a layer handler (to handle things like transforming textures)
func PopulateLayerHandlerComponents(obj):
	#if obj.depth_scaler != null:
	pass
