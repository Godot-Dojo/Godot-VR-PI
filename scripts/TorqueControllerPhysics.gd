extends RigidBody3D

@export var target = Node3D
@export var grabpoint = Node3D
@export var controller = XRController3D
@export var body = RigidBody3D
@export var angular_spring_stiffness = 100
@export var angular_spring_damping = 10
@export var max_angular_force = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_transform: Transform3D = controller.global_transform
	var current_transform: Transform3D = global_transform
	var rotation_difference: Basis = (target_transform.basis * current_transform.basis.inverse())
	var torque = hookes_law(rotation_difference.get_euler(), angular_velocity, angular_spring_stiffness, angular_spring_damping)
	torque = torque.limit_length(max_angular_force)
	angular_velocity += torque * delta
	

# spring related function
func hookes_law(displacement: Vector3, current_velocity: Vector3, stiffness: float, damping: float) -> Vector3:
	return (stiffness * displacement) - (damping * current_velocity)
