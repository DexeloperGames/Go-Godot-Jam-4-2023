shader_type canvas_item;
uniform int primitive_type : hint_range(0,4);
global uniform vec4 primitive_color_0;
global uniform vec4 primitive_color_1;
global uniform vec4 primitive_color_2;
global uniform vec4 primitive_color_3;
global uniform vec4 primitive_color_4;


void fragment(){
	switch(primitive_type){
		case 0u: COLOR *= primitive_color_0; break;
		case 1u: COLOR *= primitive_color_1; break;
		case 2u: COLOR *= primitive_color_2; break;
		case 3u: COLOR *= primitive_color_3; break;
		case 4u: COLOR *= primitive_color_4; break;
	}
}