extends Character
class_name Azure

@onready var DoorIcon = $DoorIcon
@onready var label : Label = $Label
@onready var LedgeGrabDetector : c_LedgeGrab = $c_LedgeGrab

enum STATE {
	IDLE,
	WALK,
	AIR,
	LEDGE
}

var State : int = STATE.IDLE

func _ready():
	_onActorReady()
	_onCharacterReady()
	LedgeGrabDetector.connect("ledge_detected", GrabLedge)

func _physics_process(delta):
	if Input.is_key_pressed(KEY_1):
		CurrentLayer = 1
	if Input.is_key_pressed(KEY_2):
		CurrentLayer = 2
	if Input.is_key_pressed(KEY_3):
		CurrentLayer = 3
	if Input.is_key_pressed(KEY_4):
		CurrentLayer = 4
	call(STATE.keys()[State])

func IDLE():
	if Input.is_action_just_pressed("jump"):
		InteractButton.ExecuteCurrentButtonAction(self)
	HandleDirection()
	if !is_on_floor():
		State = STATE.AIR
		return
	if velocity.x != 0.0:
		State = STATE.WALK
		return

func WALK():
	if Input.is_action_just_pressed("jump"):
		InteractButton.ExecuteCurrentButtonAction(self)
	HandleDirection()
	if !is_on_floor():
		State = STATE.AIR
		return
	if velocity.x == 0.0:
		State = STATE.IDLE
		return

func AIR():
	#falling ledge grab detector
	LedgeGrabDetector.enabled = velocity.y > 0
	HandleDirection()
	if is_on_floor():
		State = STATE.IDLE
		return

func LEDGE():
	if Input.is_action_just_pressed("jump"):
		InteractButton.ExecuteCurrentButtonAction(self)
		State = STATE.AIR

func HandleDirection():
	var direction = Input.get_axis("left", "right")
	if direction != 0.0:
		Walk.SetDirection(self, direction)
		Walk.Step(self)
	else:
		Walk.Hold(self)

func GrabLedge(ledge : GrabbableLedge):
	print("Grab ledge: " + ledge.name)
	#get relative position of character & ledge (for direction detection)
	var vec : Vector2 = ledge.global_position - global_position
	#check holding forward
	if vec.x / abs(vec.x) == Input.get_axis("left", "right"):
		#turn off ledge detection
		LedgeGrabDetector.enabled = false
		#set ledge grab state
		State = STATE.LEDGE
		#push copy of jump action with different condition
		#ButtonAction.
