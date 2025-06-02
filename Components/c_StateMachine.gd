extends Node2D
class_name c_StateMachine

var States : Dictionary
var CurrentState : String

func AddState(state : Callable):
	var stateName : String = state.get_method()
	States[stateName] = state

func GetCurrent():
	return CurrentState

func ExecuteCurrent():
	ExecuteByName(CurrentState)

func ExecuteByName(name : String):
	var stateToExecute : Callable = States[name]
	if stateToExecute != null:
		stateToExecute.call()
