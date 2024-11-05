mp.add_key_binding("L", "end", function()
	local duration = mp.get_property("duration")
	if duration then
		mp.commandv("seek", duration, "absolute")
		mp.set_property("pause", "no")
	end
end)
