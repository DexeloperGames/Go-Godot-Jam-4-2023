shader_type spatial;
global uniform vec4 primitive_color_0;
void fragment() {
	ALBEDO = primitive_color_0.rgb;
	// Place fragment code here.
}
