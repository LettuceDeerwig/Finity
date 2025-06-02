extends Node2D
class_name c_Walk

enum DIRECTION {
	LEFT = -1,
	NONE = 0,
	RIGHT = 1
}

@onready var character_body : CharacterBody2D = get_parent()

@export var Velocity : c_Velocity
@export var Direction : int = DIRECTION.RIGHT

func SetDirection(obj : CollisionObject2D, direction : int):
	if Direction != direction:
		obj.scale.x *= -1
	Direction = direction

func Step(obj : CollisionObject2D):
	#Handle walking animation
	Velocity.Accelerate(Direction)
	HandleGravity(obj)
	Velocity.Move(obj)
			
func Hold(obj : CollisionObject2D):
	Velocity.Decelerate(Direction)
	HandleGravity(obj)
	Velocity.Move(obj)
	
func HandleGravity(obj : CollisionObject2D):
	if !obj.is_on_floor():
		Velocity.AddGravity()
