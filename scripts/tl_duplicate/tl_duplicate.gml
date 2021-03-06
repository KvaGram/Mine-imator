/// tl_duplicate()
/// @desc Duplicates the given timeline and children. Returns the new one.

copy = new(obj_timeline)
tl_copy(copy)

with (copy)
{
	root_copy = null
	copy = null
	
	if (temp && part_of = null)
		temp.count++
		
	// Copy default values
	for (var v = 0; v < e_value.amount; v++)
		value_default[v] = tl_value_find_save_id(v, null, other.value_default[v])
		
	// Copy keyframes
	for (var k = 0; k < ds_list_size(other.keyframe_list); k++)
	{
		var oldkf, newkf;
		oldkf = other.keyframe_list[|k]
		newkf = new(obj_keyframe)
		newkf.position = oldkf.position
		newkf.timeline = id
		newkf.selected = false
		newkf.sound_play_index = null
		for (var v = 0; v < e_value.amount; v++)
			newkf.value[v] = oldkf.value[v]
		ds_list_add(keyframe_list, newkf)
	}
	
	// Copy tree structure
	for (var t = 0; t < ds_list_size(other.tree_list); t++)
	{
		with (other.tree_list[|t])
			ds_list_add(other.tree_list, tl_duplicate())
		tree_list[|t].parent = id
	}
	
	// Copy body part references
	if (other.part_list != null)
	{
		part_list = ds_list_create()
		for (var p = 0; p < ds_list_size(other.part_list); p++)
		{
			part_list[|p] = other.part_list[|p].copy
			part_list[|p].part_of = id
		}
	}
	
	// Update
	tl_update_scenery_part()
	tl_update()
	tl_update_values()
		
	return id
}