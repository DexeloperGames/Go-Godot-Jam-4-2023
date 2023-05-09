extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.global_shader_parameter_set("primitive_color_0", Color.TRANSPARENT)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
