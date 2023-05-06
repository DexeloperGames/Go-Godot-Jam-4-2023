shader_type spatial;

void vertex(){
	COLOR.rgb = VERTEX;
	VERTEX += sin(TIME)*0.1;
}

void fragment() {
	// Place fragment code here.
}
