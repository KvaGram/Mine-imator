/// tl_copy(to)
/// @arg to
/// @desc Copies all the variables into the given object.

var to = argument0;

to.type = type
to.name = name
to.temp = temp
to.text = text
to.color = color
to.lock = lock
to.hide = hide
to.depth = depth

to.lock_bend = lock_bend
to.parent = parent
if (object_index = obj_timeline)
	to.parent_tree_index = ds_list_find_index(parent.tree_list, id)
else // History object (copy)
	to.parent_tree_index = parent_tree_index
to.tree_extend = tree_extend

to.model_part = model_part
to.model_part_name = model_part_name
to.part_of = part_of

to.inherit_position = inherit_position
to.inherit_rotation = inherit_rotation
to.inherit_rot_point = inherit_rot_point
to.inherit_scale = inherit_scale
to.inherit_alpha = inherit_alpha
to.inherit_color = inherit_color
to.inherit_visibility = inherit_visibility
to.inherit_bend = inherit_bend
to.inherit_texture = inherit_texture
to.scale_resize = scale_resize
to.rot_point_custom = rot_point_custom
to.rot_point = point3D_copy(rot_point)
to.backfaces = backfaces
to.texture_blur = texture_blur
to.texture_filtering = texture_filtering
to.round_bending = round_bending
to.shadows = shadows
to.ssao = ssao
to.fog = fog
to.wind = wind
to.wind_terrain = wind_terrain

if (part_of != null && part_of != "")
{
	if (type = e_temp_type.SPECIAL_BLOCK)
	{
		to.model_name = model_name
		to.model_state = array_copy_1d(model_state)
	}
	else if (type = e_temp_type.BLOCK)
	{
		to.block_name = block_name
		to.block_state = array_copy_1d(block_state)
	}
}