extends "res://Components/c_ButtonAction.gd"
class_name c_ToLayer

@export var to_layer : int = 1

func _ready():
	Action = Teleport

func CanPerform(characterBody : CharacterBody2D) -> bool:
	return characterBody is Actor && characterBody.is_on_floor()

func Teleport(characterBody : CharacterBody2D):
	characterBody.Layer.ChangeLayer(to_layer)
