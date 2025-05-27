extends "res://Actors/Actor.gd"

@onready var DoorIcon = $DoorIcon
@onready var vLabel = $Label

func _physics_process(delta):
	if Input.is_key_pressed(KEY_1):
		CurrentLayer = 1
	if Input.is_key_pressed(KEY_2):
		CurrentLayer = 2
	if Input.is_key_pressed(KEY_3):
		CurrentLayer = 3
	if Input.is_key_pressed(KEY_4):
		CurrentLayer = 4
	DoorIcon.visible = true if buttonActions[0].Type == "door" else false
	if Input.is_action_just_pressed("jump"):
		InteractButton.ExecuteCurrentButtonAction(self)
	var direction = Input.get_axis("left", "right")
	Walk.SetDirection(direction)
	if direction != 0.0:
		Walk.Step()
	else:
		Walk.Hold()
	vLabel.text = "Velocity.x: " + str(velocity.x) + "\nVelocity.y: " + str(velocity.y)
	vLabel.text += "\nHandlerVelocity.x: " + str($c_Velocity.velocity.x) + "\nHandlerVelocity.y: " + str($c_Velocity.velocity.y)
