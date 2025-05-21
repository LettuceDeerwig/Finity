shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D curve;

bool pixelIsCenter(vec2 uv) {
	return uv.x >= 0.495 && uv.x <= 0.505
		&& uv.y >= 0.495 && uv.y <= 0.505;
}

void fragment() {
	vec2 vec_pixToCenter = vec2(0.5, 0.5) - UV;
	float len_pixToCenter = length(vec_pixToCenter);
	float curveVal = texture(curve, vec2(len_pixToCenter)).r;
	vec2 diff = normalize(vec_pixToCenter) * 0.2 * curveVal;
	COLOR = curveVal >= 0.0 && !pixelIsCenter(UV) ?
		texture(SCREEN_TEXTURE, SCREEN_UV - diff)
		: texture(TEXTURE, SCREEN_UV - diff);
}
