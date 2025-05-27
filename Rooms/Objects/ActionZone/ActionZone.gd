extends Area2D
class_name ActionZone

@export var Action : c_ButtonAction
@export var Layer : c_LayerHandler

@onready var InstanceId : int = self.get_instance_id()

var ActorsInZone : Array[Node2D]

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
func _on_body_entered(actor : Actor):
	if GetActorIsValid(actor):
		actor.InteractButton.AddButtonAction(Action)
		RefreshActorsInZone()
#Refresh contained actors list when one exits
func _on_body_exited(actor : Actor):
	actor.InteractButton.RemoveButtonAction(InstanceId)
	RefreshActorsInZone()

func RefreshActorsInZone():
	ActorsInZone.clear()
	for actor in get_overlapping_bodies():
		if GetActorIsValid(actor):
			ActorsInZone.push_back(actor)
