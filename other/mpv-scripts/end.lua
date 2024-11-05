mp.add_key_binding("L", "end", function()
	local duration = mp.get_property("duration")
	local filename = mp.get_property("filename")
	if duration then
		mp.commandv("seek", duration, "absolute")
		-- Check if the file is an image based on its extension
		local is_image = filename:match("%.png$")
			or filename:match("%.jpg$")
			or filename:match("%.jpeg$")
			or filename:match("%.gif$")
			or filename:match("%.bmp$")
			or filename:match("%.tiff$")
		if is_image then
			mp.set_property("pause", "no")
		end
	end
end)
