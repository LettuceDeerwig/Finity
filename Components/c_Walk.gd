extends Node2D
class_name c_Walk

enum DIRECTION {
	LEFT = -1,
	RIGHT = 1
}

@onready var character_body : CharacterBody2D = get_parent()

@export var Velocity : c_Velocity
@export var Direction : int = DIRECTION.RIGHT

func SetDirection(direction : int):
	Direction = direction

func Step():
	#Handle walking animation
	Velocity.Accelerate(Direction)
	HandleGravity()
	Velocity.Move(character_body)
			
func Hold():
	Velocity.Decelerate()
	HandleGravity()
	Velocity.Move(character_body)
	
func HandleGravity():
	if !character_body.is_on_floor():
		Velocity.AddGravity()
