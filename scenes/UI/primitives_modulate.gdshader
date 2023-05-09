shader_type canvas_item;
uniform int primitive_type : hint_range(0,4);
global uniform vec4 primitive_color_0;
global uniform vec4 primitive_color_1;
global uniform vec4 primitive_color_2;
global uniform vec4 primitive_color_3;
global uniform vec4 primitive_color_4;


void fragment(){
	vec3 new_color = vec3(1.0);
	switch(primitive_type){
		case 0u: new_color= primitive_color_0.rgb; break;
		case 1u: new_color= primitive_color_1.rgb; break;
		case 2u: new_color= primitive_color_2.rgb; break;
		case 3u: new_color= primitive_color_3.rgb; break;
		case 4u: new_color= primitive_color_4.rgb; break;
	}
	COLOR.rgb = vec3(1.0);
}