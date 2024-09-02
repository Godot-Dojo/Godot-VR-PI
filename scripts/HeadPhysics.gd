extends RigidBody3D

@export var target = Node3D
var speed = 60
var touching = false
var object
var offset = Vector3.ZERO
var grabbing = false

func _process(delta):
	linear_velocity = (target.global_position - global_transform.origin) * speed
