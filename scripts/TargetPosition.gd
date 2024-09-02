extends RigidBody3D

@export var target = Node3D
var speed = 100

func _process(delta):
	linear_velocity = (target.global_position - global_transform.origin) * speed
