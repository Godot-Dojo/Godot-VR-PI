extends RigidBody3D

@export var PlayerHead = Node3D
@export var HeightMin = 0.5
@export var HeightMax = 2
@export var Speed : float = 3

@onready var BodyCollider = $CollisionShape3D
@onready var BodyShape = $MeshInstance3D
@onready var LeftControllerPhysics = $LeftControllerPhysics
@onready var RightControllerPhysics = $RightControllerPhysics
@onready var LeftController = $XROrigin3D/LeftController
@onready var RightController = $XROrigin3D/RightController
@onready var Camera = $XROrigin3D/XRCamera3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	BodyCollider.shape.height = clampf(PlayerHead.position.y,HeightMin,HeightMax)
	BodyCollider.position = Vector3(PlayerHead.position.x,BodyCollider.shape.height/2,PlayerHead.position.z)
	BodyShape.mesh.height = clampf(PlayerHead.position.y,HeightMin,HeightMax)
	BodyShape.position = Vector3(PlayerHead.position.x,BodyShape.mesh.height/2,PlayerHead.position.z)
	var camera_transform = Camera.global_transform
	var camera_basis = camera_transform.basis
	var camera_forward = -camera_basis.z.normalized()
	var camera_right = camera_basis.x.normalized()
	var input_vector = Vector2(LeftController.get_vector2("primary").x, LeftController.get_vector2("primary").y)
	var movement_vector = camera_right * input_vector.x + camera_forward * input_vector.y
	linear_velocity.x = movement_vector.x * Speed
	linear_velocity.z = movement_vector.z * Speed
	if LeftControllerPhysics.touching or (LeftControllerPhysics.grabbing and not LeftControllerPhysics.object is RigidBody3D):
		apply_impulse(LeftControllerPhysics.offset*-5)
	if RightControllerPhysics.touching or (RightControllerPhysics.grabbing and not RightControllerPhysics.object is RigidBody3D):
		apply_impulse(RightControllerPhysics.offset*-5)
	rotation_degrees.y -= RightController.get_vector2("primary").x
