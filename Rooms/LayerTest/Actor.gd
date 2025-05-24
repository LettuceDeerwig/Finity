extends CharacterBody2D

@export var speed = 300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var buttonActions : Array[Dictionary] = [{"Action": Callable(self, "Jump"),
			"Priority": 0,
			"Type": "jump",
			"InstanceId": null}]

@onready var LayerHandler = $c_LayerHandler 

var CurrentLayer: int :
	get:
		return LayerHandler.GetLayer(self)
	set(value):
		LayerHandler.ChangeLayer(value)

#Adds button action to list, with highest priority first
func AddButtonAction(action, priority, type, instanceId):
	var existingIndex = GetButtonActionIndexWithInstanceId(instanceId)
	if existingIndex == -1:
		var insertIndex = 0
		#Insert in front of first item with lower priority (and after equals)
		while insertIndex < buttonActions.size():
			if buttonActions[insertIndex].Priority < priority:
				break
			else:
				insertIndex += 1
		#Insert button action
		buttonActions.insert(
			insertIndex,
			{"Action": action,
			"Priority": priority,
			"Type": type,
			"InstanceId": instanceId})
	
func RemoveButtonAction(instanceId):
	var existingIndex = GetButtonActionIndexWithInstanceId(instanceId)
	if existingIndex > -1:
		buttonActions.remove_at(existingIndex)
	
func GetButtonActionIndexWithInstanceId(instanceId):
	for i in buttonActions.size():
		if (buttonActions[i].InstanceId == instanceId):
			return i
	return -1

func ExecuteCurrentButtonAction():
	var action = buttonActions[0];
	var canPerformAction = false
	match (action.Type):
		_:
			canPerformAction = is_on_floor()
	if canPerformAction:
		action.Action.call(self)
