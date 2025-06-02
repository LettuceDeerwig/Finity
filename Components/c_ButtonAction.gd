extends Node2D
class_name c_ButtonAction

var Action : Callable
@export var Priority : int = 0
@export var Type : String
var InstanceId : int

func _ready():
	_onButtonActionReady()
	
func _onButtonActionReady():
	InstanceId = get_instance_id()

func CanPerform(characterBody : CharacterBody2D) -> bool:
	return true

func Perform(characterBody : CharacterBody2D):
	Action.call(characterBody)
