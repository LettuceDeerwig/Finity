@tool
extends StaticBody2D

@onready var VisualPolygon = $VisualPolygon
@onready var CollisionPolygon = $CollisionPolygon

func _ready():
	CollisionPolygon.polygon = VisualPolygon.polygon
