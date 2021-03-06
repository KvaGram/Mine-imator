/// render_start(target, camera, [width, height])
/// @arg target
/// @arg camera
/// @arg [width
/// @arg height]

render_target = argument[0]
render_camera = argument[1]
render_width = project_video_width
render_height = project_video_height

// Use camera settings
if (render_camera != null)
{
	if (!render_camera.value[e_value.CAM_SIZE_USE_PROJECT])
	{
		render_width = render_camera.value[e_value.CAM_WIDTH]
		render_height = render_camera.value[e_value.CAM_HEIGHT]
	}
	
	render_camera_colors = (render_camera.colors_ext ||
							render_camera.value[e_value.ALPHA] < 1 || 
							render_camera.value[e_value.BRIGHTNESS] > 0)
	
	render_camera_dof = (setting_render_dof && render_camera.value[e_value.CAM_DOF])
}
else 
{
	render_camera_colors = false
	render_camera_dof = false
}

// Argument overwrites size
if (argument_count > 2)
{
	render_width = argument[2]
	render_height = argument[3]
}

render_ratio = render_width / render_height
render_overlay = (render_camera_colors || render_watermark)

render_prev_color = draw_get_color()
render_prev_alpha = draw_get_alpha()
draw_set_color(c_white)
draw_set_alpha(1)

render_update_text()

camera_apply(cam_render)