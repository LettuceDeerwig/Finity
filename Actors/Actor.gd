extends CharacterBody2D
class_name Actor

var buttonActions : Array[Dictionary] = [{"Action": Callable(self, "Jump"),
			"Priority": 0,
			"Type": "jump",
			"InstanceId": null}]

@export var texture : Sprite2D
@export var Layer : c_LayerHandler
@export var Walk : c_Walk
@export var StateMachine : c_StateMachine

@onready var InteractButton : c_InteractButton = $c_InteractButton
@onready var Jump : c_Jump = $c_Jump

var CurrentLayer: int :
	get:
		return Layer.GetLayer(self)
	set(value):
		Layer.ChangeLayer(value)

func _ready():
	InteractButton.AddButtonAction(Jump)

func Interact():
	var action = InteractButton.GetHighestPriorityAvailableButtonAction(self)
	if action != null:
		action.Action.call(self)
