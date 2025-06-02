extends Character
@onready var Animations : AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	var direction = Input.get_axis("arrow_left", "arrow_right")
	Walk.SetDirection(self, direction)
	if direction != 0.0:
		Walk.Step(self)
	else:
		Walk.Hold(self)	
	
	if Input.is_action_just_pressed("p"):
		Animations.play("swing")
		Animations.queue("RESET")
