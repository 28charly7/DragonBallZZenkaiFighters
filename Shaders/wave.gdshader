shader_type canvas_item;

uniform float pulse_strength : hint_range(0.0, 1.0) = 0.2;
uniform float time_speed = 1.0;

void fragment() {
    float time = TIME * time_speed;
    vec2 uv = UV;

    float dist = distance(uv, vec2(0.5));
    float pulse = sin(time * 6.0 - dist * 20.0) * 0.5 + 0.5; // normalizado 0..1
    float brightness = 1.0 + pulse * pulse_strength;

    vec3 base_color = texture(TEXTURE, uv).rgb;
    COLOR.rgb = base_color * brightness;
    COLOR.a = texture(TEXTURE, uv).a;
}