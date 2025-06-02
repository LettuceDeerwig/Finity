extends RayCast2D
class_name c_LedgeGrab

signal ledge_detected

var StoredYPoint : float

func _physics_process(delta: float) -> void:
	if enabled:
		#capture previous target y value
		var previousYPoint = StoredYPoint
		#capture current target y value
		var currentYPoint = target_position.y
		#extend target to previous position
		target_position.y = previousYPoint
		#check collision
		if is_colliding():
			var ledge : GrabbableLedge = get_collider()
			ledge_detected.emit(ledge)
		#reset target position
		target_position.y = currentYPoint
		#store target y value for next frame
		StoredYPoint = target_position.y
