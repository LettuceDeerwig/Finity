extends Node2D

@export var layer_1 : Node2D
@export var layer_2 : Node2D
@export var layer_3 : Node2D

func _ready():
	var layerHandlers : Array[Node] = get_tree().get_nodes_in_group("LayerHandler")
	for lh in layerHandlers:
		if layer_1.is_ancestor_of(lh):
			lh.initial_room_layer = 1
		if layer_2.is_ancestor_of(lh):
			lh.initial_room_layer = 2
		if layer_3.is_ancestor_of(lh):
			lh.initial_room_layer = 3
		lh.connect("_request_reparent", ReparentObjectToNewLayer)
		PopulateLayerHandlerComponents(lh)
		lh.InitializeObjectLayers()			

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
func PopulateLayerHandlerComponents(lh):
	if lh.depth_scaler != null:
		
