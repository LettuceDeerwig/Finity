extends Actor
class_name Character

@export var texture : Sprite2D
@export var Walk : c_Walk

@onready var InteractButton : c_InteractButton = $c_InteractButton
@onready var Jump : c_Jump = $c_Jump

func _ready():
	_onActorReady()
	_onCharacterReady()

func _onCharacterReady():
	InteractButton.AddButtonAction(Jump)

func Interact():
	var action = InteractButton.GetHighestPriorityAvailableButtonAction(self)
	if action != null:
		action.Action.call(self)
