shader_type canvas_item;

void fragment() {
	float alpha = smoothstep(0.45, 0.4, length(UV - vec2(0.5, 0.5)));
	COLOR = vec4(0.0, 0.0, 0.0, alpha);
}
