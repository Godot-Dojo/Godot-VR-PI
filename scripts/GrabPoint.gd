extends Node3D

@export var controller = XRController3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = controller.global_rotation
	


