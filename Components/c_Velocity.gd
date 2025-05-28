extends Node2D
class_name c_Velocity

@export var max_speed : float = 300.0
@export var acceleration : float = 300.0
@export var deceleration : float = 300.0
@export var velocity : Vector2
@export var gravity_controller : c_Gravity

@onready var Modifiers : c_ModifierHandler = $c_ModifierHandler

func _ready():
	if acceleration == 0.0:
		acceleration = max_speed
	if deceleration == 0.0:
		deceleration = acceleration

func Move(characterBody : CharacterBody2D):
	characterBody.velocity = Vector2(Modifiers.ApplyAll(velocity.x),
										Modifiers.ApplyAll(velocity.y))
	characterBody.move_and_slide()
	if characterBody.velocity.y == 0.0:
		velocity.y = 0.0
	
func Accelerate(direction : int):
	velocity.x = direction * (minf(max_speed, abs(velocity.x) + acceleration))

func Decelerate():
	velocity.x = maxf(0, velocity.x - deceleration)

func AddGravity():
	if gravity_controller != null:
		velocity.y = minf(gravity_controller.terminal_velocity, velocity.y + gravity_controller.gravity)
	else:
		velocity.y = 0
