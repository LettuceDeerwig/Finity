extends "res://Components/c_ButtonAction.gd"
class_name c_Jump

@export var Velocity : c_Velocity

@export var jump_velocity = -400.0

func _ready():
	Action = Jump 

func CanPerform(characterBody : CharacterBody2D) -> bool:
	return characterBody.is_on_floor()

func Jump(characterBody : CharacterBody2D):
	Velocity.velocity.y += jump_velocity
