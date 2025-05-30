extends Area2D
class_name c_Hitbox

@export var Active : bool = true :
	get:
		return Active
	set(value):
		Active = value
		Shape.disabled = !value

@onready var Shape : CollisionShape2D = $Shape

func _on_area_entered(hurtbox : c_Hurtbox):
	print("I hit you")
