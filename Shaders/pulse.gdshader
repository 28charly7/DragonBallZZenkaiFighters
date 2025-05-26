shader_type canvas_item;

uniform float speed_pulse = 1.0;
uniform float init_offset = 0.5;
uniform float pixel_size = 0.05;

void fragment() {
	vec2 uv = UV - vec2(init_offset); 
	//vec2 uv1 = floor(UV / pixel_size) * pixel_size;
	//vec2 uv2 = uv + uv1;
	float dist = length(uv) * 2.0; //length posicion del vector uv
	dist = dist * sin(TIME * speed_pulse) * 0.03;
	COLOR = texture(TEXTURE, UV + uv * dist);
	
}
	
