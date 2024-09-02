extends RigidBody3D

@export var Target = Node3D

func _physics_process(delta):
	global_position = Target.global_position
