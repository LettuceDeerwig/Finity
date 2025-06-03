extends "res://Components/c_ButtonAction.gd"
class_name c_Jump

@export var Velocity : c_Velocity
@export var jump_velocity = -400.0

@onready var Modifiers : c_ModifierHandler = $c_ModifierHandler

func _ready():
	_onButtonActionReady()
	Action = Jump

func CanPerform(characterBody : CharacterBody2D) -> bool:
	return true

func Jump(characterBody : CharacterBody2D):
	Velocity.velocity.y += jump_velocity
