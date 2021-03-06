/// render_generate_text(string, resource, 3d)
/// @arg string
/// @arg resource
/// @arg 3d
/// @desc Generates a vbuffer and a surface (text_vbuffer, text_texture)

var str, res, is3d;
str = argument0
res = argument1
is3d = argument2

if (text_texture != null && text_string = str && text_res = res && text_3d = is3d)
	return 0

if (string_char_at(str, string_length(str)) = "\n")
	str += " "
	
text_string = str
text_res = res
text_3d = is3d

draw_set_font(res.font)

// Calculate dimensions
var wid, hei, xx, zz;
wid = string_width(str) + 1
hei = string_height_ext(str, string_height(" ") + 2, -1) + 1
xx = -wid / 2
zz = -hei / 2

// Generate surface with text on it (padded by 1px to avoid artifacts)
var surf = surface_create(wid + 2, hei + 2);
surface_set_target(surf)
{
	draw_clear_alpha(c_black, 0)
	var color = draw_get_color();
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_ext(ceil(wid / 2) + 1, ceil(hei / 2) + 1, str, string_height(" ") + 2, -1)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_color(color)
}
surface_reset_target()
texture_global_scale(1)
draw_set_font(app.setting_font)

// Create texture
if (text_texture != null)
	texture_free(text_texture)
text_texture =  texture_surface(surf)

// Create vbuffer
text_vbuffer = vbuffer_start()

// 3D pixels
if (is3d)
	vbuffer_add_pixels(surface_get_alpha_array(surf), point3D(xx, 0, zz), hei, point2D(0, 0), vec2(wid + 2, hei + 2), vec2(1 / (wid + 2), 1 / (hei + 2)), vec3(1), point2D(1, 1), point2D(-2, -2), false)

var ysize, p1, p2, p3, p4, tsize, t1, t2, t3, t4,;
t1 = vec2(1, 1)
t2 = vec2(wid + 1, 1)
t3 = vec2(wid + 1, hei + 1)
t4 = vec2(1, hei + 1)

// Convert coordinates to 0-1
tsize = vec2(wid + 2, hei + 2)
t1 = vec2_div(t1, tsize)
t2 = vec2_div(t2, tsize)
t3 = vec2_div(t3, tsize)
t4 = vec2_div(t4, tsize)
ysize = test(is3d, 1, 0)

// Front
p1 = point3D(xx, ysize, zz + hei)
p2 = point3D(xx + wid, ysize, zz + hei)
p3 = point3D(xx + wid, ysize, zz)
p4 = point3D(xx, ysize, zz)
vbuffer_add_triangle(p1, p2, p3, t1, t2, t3)
vbuffer_add_triangle(p3, p4, p1, t3, t4, t1)

// Back
p1 = point3D(xx, 0, zz + hei)
p2 = point3D(xx + wid, 0, zz + hei)
p3 = point3D(xx + wid, 0, zz)
p4 = point3D(xx, 0, zz)
vbuffer_add_triangle(p2, p1, p3, t2, t1, t3)
vbuffer_add_triangle(p4, p3, p1, t4, t3, t1)

surface_free(surf)
vbuffer_done()