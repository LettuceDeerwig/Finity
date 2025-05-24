extends "res://Rooms/LayerTest/Actor.gd"

@export var jump_velocity = -400.0

@onready var DoorIcon = $DoorIcon

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
		ExecuteCurrentButtonAction()
	HandleBasicMovement(delta)

func HandleBasicMovement(delta):
	var move_speed = speed * 2 if Input.is_physical_key_pressed(KEY_SHIFT) else speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()

func Jump(_self):
	velocity.y = jump_velocity
