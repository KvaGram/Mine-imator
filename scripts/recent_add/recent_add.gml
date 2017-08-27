/// recent_add()
/// @desc Adds the opened project to the top of the recent list.

recent_add_wait = false

// Find project in list
var obj = null;
for (var i = 0; i < ds_list_size(recent_list); i++)
{
	with (recent_list[|i])
	{
		if (filename != app.project_file)
			break
			
		obj = id
		ds_list_delete_value(app.recent_list, id)
		if (thumbnail != null)
			texture_free(thumbnail)
	}
	
	if (obj != null)
		break
}

// Create thumbnail
var thumbnailfn, surf;
thumbnailfn = project_folder + "\\thumbnail.png"
surf = null
render_start(surf, timeline_camera, recent_thumbnail_width, recent_thumbnail_height)
render_low()
surf = render_done()
surface_save_lib(surf, thumbnailfn)
surface_free(surf)

// Project not added, create new object
if (obj = null)
	obj = new(obj_recent)

// Store data
with (obj)
{
	filename = app.project_file
	name = app.project_name
	author = app.project_author
	description = app.project_description
	date = date_current_datetime()
	thumbnail = texture_create(thumbnailfn)
	ds_list_insert(app.recent_list, 0, id)
}