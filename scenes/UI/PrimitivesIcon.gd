@tool
extends TextureRect
class_name PrimitivesIcon

@export_range(0,4) var primitive_type : int = 0:
	set(n_type):
		primitive_type = n_type
		print("yeah type changed")
		if n_type < len(primitives_icons):
			texture = primitives_icons[n_type]
			material.set_shader_parameter("primitive_type", n_type)
@export var primitives_icons : Array[Texture]

# Called when the node enters the scene tree for the first time.
func _ready():
	print("yeah tool loaded wooo")
	primitive_type = primitive_type
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
