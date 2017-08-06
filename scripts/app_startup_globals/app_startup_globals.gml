/// app_startup_globals()

log("Globals startup")

// Program
globalvar trial_version, current_step, minute_steps, delta,
		  buffer_current, vbuffer_current, load_format, load_folder, save_folder, load_iid_offset, 
		  debug_indent, debug_timer, history_data;
current_step = 0
minute_steps = 60 * 60
delta = 1

// Assets
globalvar temp_edit, ptype_edit, tl_edit_amount, tl_edit, res_edit, axis_edit,
		  temp_creator, res_creator, iid_current;
temp_edit = null
ptype_edit = null
tl_edit = null
tl_edit_amount = 0
res_edit = null
axis_edit = X
temp_creator = app
res_creator = app
iid_current = 1

// Camera
globalvar cam_from, cam_to, cam_up, cam_fov, cam_ratio, cam_near, cam_far, cam_window, cam_render;
cam_from = point3D(0, 0, 0)
cam_window = camera_create()
cam_render = camera_create()
view_set_camera(0, cam_window)