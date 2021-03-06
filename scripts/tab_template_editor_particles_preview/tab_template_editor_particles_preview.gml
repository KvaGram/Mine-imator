/// tab_template_editor_particles_preview()

var size, xx, yy;
size = 64
tab_control(size)

xx = floor(dx + dw / 2 - size / 2)
yy = floor(dy)

if (xx + size < content_x || xx > content_x + content_width || yy + size < content_y || yy > content_y + content_height)
{
	tab_next()
	return 0
}

tip_set(text_get("particleeditortypespriteanimationpreviewtip"), xx, yy, size, size)

var res, tex, swid, fwid, fhei, ani, frame, framesx, scale;
res = ptype_edit.sprite_tex
if (!res.ready)
	res = mc_res
tex = res.particles_texture[ptype_edit.sprite_tex_image]
swid = texture_width(tex)
fwid = min(swid, ptype_edit.sprite_frame_width)
fhei = ptype_edit.sprite_frame_height
ani = particle_get_animation_percent(particle_editor_preview_start, ptype_edit.sprite_frame_start, ptype_edit.sprite_frame_end, particle_editor_preview_speed, ptype_edit.sprite_animation_onend)
frame = round(ptype_edit.sprite_frame_start + (ptype_edit.sprite_frame_end - ptype_edit.sprite_frame_start) * ani)
framesx = swid div fwid

scale = min(size / fwid, size / fhei)

draw_box(xx, yy, size, size, false, c_black, 0.1)
draw_texture_start()
draw_texture_part(tex, xx, yy, (frame mod framesx) * fwid, (frame div framesx) * fhei, fwid, fhei, scale, scale)
draw_texture_done()

if (draw_button_normal("", xx + size - 16, yy + size - 16, 16, 16, e_button.NO_TEXT, false, true, true, icons.ARROW_RIGHT_SMALL))
	tab_template_editor_particles_preview_restart()

tab_next()
