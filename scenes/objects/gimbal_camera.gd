extends Node3D
class_name GimbalCamera

@onready var camera : Camera3D = get_node("Yaw/Pitch/Roll/Camera3D")

@export var gimbal_rotation_degrees : Vector3 = Vector3.ZERO:
	set(n_degrees):
		gimbal_rotation_degrees = n_degrees
		update_rotation()
# Called when the node enters the scene tree for the first time.
var camera_global_transform : Transform3D:
	get:
		return $Yaw/Pitch/Roll/Camera3D.global_transform
func update_rotation():
	$Yaw.rotation_degrees.y = gimbal_rotation_degrees.x
	$Yaw/Pitch.rotation_degrees.x = gimbal_rotation_degrees.y
	$Yaw/Pitch/Roll.rotation_degrees.z = gimbal_rotation_degrees.z
	
	
	pass

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
