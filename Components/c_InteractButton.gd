extends Node2D
class_name c_InteractButton

@export var Actions : Array[c_ButtonAction]

#Adds button action to list, with highest priority first
func AddButtonAction(action : c_ButtonAction):
	var existingIndex = GetButtonActionIndexWithInstanceId(action.InstanceId)
	if existingIndex == -1:
		var insertIndex = 0
		#Insert in front of first item with lower priority (and after equals)
		while insertIndex < Actions.size():
			if Actions[insertIndex].Priority < action.Priority:
				break
			else:
				insertIndex += 1
		#Insert button action
		Actions.insert(insertIndex, action)
	
func RemoveButtonAction(instanceId):
	var existingIndex = GetButtonActionIndexWithInstanceId(instanceId)
	if existingIndex > -1:
		Actions.remove_at(existingIndex)
	
func GetButtonActionIndexWithInstanceId(instanceId):
	for i in Actions.size():
		if (Actions[i].InstanceId == instanceId):
			return i
	return -1

func GetHighestPriorityAvailableButtonAction(characterBody : CharacterBody2D) -> c_ButtonAction:
	for action in Actions:
		if action.CanPerform(characterBody):
			return action
	return null

func ExecuteCurrentButtonAction(characterBody : CharacterBody2D):
	var action : c_ButtonAction = GetHighestPriorityAvailableButtonAction(characterBody)
	if action != null:
		action.Perform(characterBody)
