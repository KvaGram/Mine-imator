/// temp_update_model()
/// @desc Gets the correct file and texture from the name and state.
///		  Also updates the affected timelines.

var model = mc_version.model_name_map[?model_name];

if (is_undefined(model))
{
	model_file = null
	model_texture_name = ""
	return 0
}
	
var vars = model_state_map;
	
// Set file and texture
with (model)
{
	var curfile, curtexname;
	curfile = file
	curtexname = ""
	
	// Texture in file < Texture in root < Texture in state (< Texture by user)
	if (file != null)
		curtexname = file.texture_name
	if (texture_name != "")
		curtexname = texture_name
	
	if (states_map != null)
	{
		var curstate = ds_map_find_first(states_map);
		while (!is_undefined(curstate))
		{
			if (!is_undefined(vars[?curstate]))
			{
				// This state has a set value, check if it matches any of the possibilities
				with (states_map[?curstate])
				{
					for (var v = 0; v < value_amount; v++)
					{
						if (vars[?curstate] != value_name[v])
							continue
							
						// Match found, get the properties and stop checking further values in this state
						
						if (value_file[v] != null)
						{
							curfile = value_file[v]
							if (curtexname = "")
								curtexname = curfile.texture_name
						}
								
						if (value_texture_name[v] != "")
							curtexname = value_texture_name[v]
								
						break
					}
				}
			}
			curstate = ds_map_find_next(states_map, curstate)
		}
	}
	
	other.model_file = curfile
	other.model_texture_name = curtexname
}

// Re-arrange timelines TODO
/*
temp_update_display_name()

with (obj_timeline) { // Rearrange hierarchy
	if (temp != other.id || part_of)
		continue
		
	for (var p = 0; p < part_amount; p++) // Set parent to root
		with (part[p])
			tl_parent_set(other.id)
			
	for (var p = 0; p < part_amount; p++) // Remove unused with 0 keyframe_amount
		with (part[p])
			if (p >= temp.char_model.part_amount && keyframe_amount = 0) 
				instance_destroy()
			
	for (var p = part_amount - 1; p >= 0; p--) { // Trim
		if (part[p])
			break
		part_amount--
	}
	
	for (var p = 0; p < temp.char_model.part_amount; p++) { // Add missing
		if (p < part_amount && part[p])
			continue
		with (new(obj_timeline)) {
			type = "bodypart"
			temp = other.temp
			bodypart = p
			part_of = other.id
			inherit_alpha = true
			inherit_color = true
			value_type_show[POSITION] = temp.char_model.part_show_position[p]
			other.part[p] = id
			other.part_amount = max(other.part_amount, p + 1)
			tl_parent_root()
		}
	}
	
	for (var p = temp.char_model.part_amount - 1; p >= 0; p--) { // Set parents
		var par = temp.char_model.part_parent[p];
		with (part[p]) {
			if (par < 0)
				tl_parent_set(other.id)
			else
				tl_parent_set(other.part[par])
			tl_update_type_name()
			tl_update_display_name()
			tl_update_value_types()
			tl_update_depth()
		}
	}
	
	tl_update_type_name()
	update_matrix = true
}*/
