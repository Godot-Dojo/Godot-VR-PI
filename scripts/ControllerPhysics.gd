extends RigidBody3D

@export var grabpoint = Node3D
@export var controller = XRController3D
@export var body = RigidBody3D
@onready var joint = $PinJoint3D
@onready var joint2 = $PinJoint3D2
@onready var LeftController = $"../XROrigin3D/LeftController"
@onready var Camera = $"../XROrigin3D/XRCamera3D"
var speed = 30
var touching = false
var object
var offset = Vector3.ZERO
var grabbing = false

func _process(delta):
	global_rotation = controller.global_rotation
	linear_velocity = (controller.global_position - global_transform.origin) * speed
	if touching or (grabbing and not object is RigidBody3D):
		offset = controller.global_position-global_position
	if controller.pressing and not object == null:
		joint.global_position = global_position
		joint2.global_position = global_position
		#object.linear_velocity = (grabpoint.global_position - object.global_transform.origin) * 10
		joint.node_b = object.get_path()
		joint2.node_b = object.get_path()
		grabbing = true
	else:
		joint.node_b = joint.node_a
		joint2.node_b = joint2.node_a
		grabbing = false
		


func _on_body_entered(body):
	if body is PhysicsBody3D and not grabbing:
		object = body
	touching = true
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

func _on_body_exited(body):
	if body is PhysicsBody3D and not grabbing:
		object = null
	touching = false
