extends "res://Components/c_ButtonAction.gd"
class_name c_ToLayer

@export var to_layer : int = 1

func _ready():
	Action = Teleport

func CanPerform(characterBody : CharacterBody2D) -> bool:
	return characterBody is Actor && characterBody.is_on_floor()

func Teleport(characterBody : Actor):
	characterBody.CurrentLayer = to_layer
