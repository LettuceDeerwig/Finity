shader_type canvas_item;

uniform vec4 bg_color : source_color;

void fragment() {
	if (distance(COLOR, bg_color) < 0.1){
		COLOR.a = 0.0;
	}
}
