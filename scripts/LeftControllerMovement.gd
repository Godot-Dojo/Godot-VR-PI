extends XRController3D

var pressing = false

func _on_button_pressed(name):
	if name == "grip_click":
		pressing = true

func _on_button_released(name):
	if name == "grip_click":
		pressing = false
