extends Area2D

@export var action_type : String = "default"

@onready var InstanceId : int = self.get_instance_id()
@onready var Action : Callable = Callable(self, "PerformAction")

var ActorsInZone : Array[Node2D]

func PerformAction(actor):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Execute any passive effects on actors within the zone
	for actor in ActorsInZone:
		AffectActorInZone(actor, delta)
	pass

#Perform action on an actor in this zone
func AffectActorInZone(actor, delta):
	pass

#Define which actors can perform this zone's action
func GetActorIsValid(actor):
	return true

#Refresh contained actors list when one enters
func _on_body_entered(actor):
	if GetActorIsValid(actor):
		actor.AddButtonAction(Action, priority, action_type, InstanceId)
		RefreshActorsInZone()
#Refresh contained actors list when one exits
func _on_body_exited(actor):
	actor.RemoveButtonAction(InstanceId)
	RefreshActorsInZone()

func RefreshActorsInZone():
	ActorsInZone.clear()
	for actor in get_overlapping_bodies():
		if GetActorIsValid(actor):
			ActorsInZone.push_back(actor)
