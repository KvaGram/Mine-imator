/// shader_use()
/// @desc Sets the shader and defines the common uniforms

shader_set(shader)

// Default color
shader_blend_color = c_white
shader_blend_alpha = 1
render_set_uniform_color("uBlendColor", c_white, 1)

// Set wind
if (!is_undefined(uniform_map[?"uTime"]) && uniform_map[?"uTime"] > -1)
{
	render_set_uniform("uTime", current_step)
	render_set_uniform("uWindEnable", 0)
	render_set_uniform("uWindTerrain", 1)
	render_set_uniform("uWindSpeed", app.background_wind * app.background_wind_speed)
	render_set_uniform("uWindStrength", app.background_wind_strength) 
}

// Set fog
if (!is_undefined(uniform_map[?"uFogShow"]) && uniform_map[?"uFogShow"] > -1)
{
	var fog = (render_lights && app.background_fog_show);
	render_set_uniform_int("uFogShow", bool_to_float(fog))

	if (fog)
	{
		render_set_uniform_color("uFogColor", app.background_fog_color_final, 1)
		render_set_uniform("uFogDistance", app.background_fog_distance)
		render_set_uniform("uFogSize", app.background_fog_size)
		render_set_uniform("uFogHeight", app.background_fog_height)
	}
}

// Init script
if (script > -1)
	script_execute(script)