extends Node2D
class_name c_PropertyScaler

@export var nodes_to_scale : Array[Node2D]
@export var scale_value : float = 1.0
var Scale:
	get:
		return scale_value
	set(value):
		scale_value = value
		ScaleNodes()

func ScaleNodes():
	for node in nodes_to_scale:
		if "Modifiers" in node && node.Modifiers is c_ModifierHandler:
			AddScaleModifier(node)
		elif "scale" in node && node.scale is Vector2:
			node.scale = Vector2(scale_value, scale_value)

func AddScaleModifier(node : Node):
	var handler : c_ModifierHandler = node.Modifiers
	var mods : Array[c_ModifierHandler.Modifier] = handler.GetBySource(self)
	if mods.size() > 0:
		#assume there is only one
		mods[0].Value = scale_value
	else:
		handler.Add(handler.TYPES.SYSTEM_END, scale_value, self)
