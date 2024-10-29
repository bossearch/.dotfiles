-- Function to show the active profile
local function show_profile()
	-- Get video properties
	local width = mp.get_property_number("width")
	local height = mp.get_property_number("height")
	local path = mp.get_property("path")
	local fps = mp.get_property_number("container-fps")
	local profile = "None"

	if width == 3840 and path:find("Videos/Movies/") and fps > 31 then
		profile = "4k60"
	elseif width == 3840 and path:find("Videos/Movies/") and fps < 31 then
		profile = "4k30"
	elseif width == 2560 and path:find("Videos/Movies/") and fps > 31 then
		profile = "2k60"
	elseif width == 2560 and path:find("Videos/Movies/") and fps < 31 then
		profile = "2k30"
	elseif width == 1920 and path:find("Videos/Movies/") and fps > 31 then
		profile = "fhd60"
	elseif width == 1920 and path:find("Videos/Movies/") and fps < 31 then
		profile = "fhd30"
	elseif width == 1280 and path:find("Videos/Movies/") and fps > 31 then
		profile = "hd30"
	elseif width == 1280 and path:find("Videos/Movies/") and fps < 31 then
		profile = "hd30"
	elseif width == 640 or width == 704 or width == 720 and path:find("Videos/Movies/") then
		profile = "sd"
	--
	elseif width == 3840 and path:find("Videos/Anime/") and fps > 31 then
		profile = "anime4k60"
	elseif width == 3840 and path:find("Videos/Anime/") and fps < 31 then
		profile = "anime4k30"
	elseif width == 2560 and path:find("Videos/Anime/") and fps > 31 then
		profile = "anime2k60"
	elseif width == 2560 and path:find("Videos/Anime/") and fps < 31 then
		profile = "anime2k30"
	elseif width == 1920 and path:find("Videos/Anime/") and fps > 31 then
		profile = "animefhd60"
	elseif width == 1920 and path:find("Videos/Anime/") and fps < 31 then
		profile = "animefhd30"
	elseif width == 1280 and path:find("Videos/Anime/") and fps > 31 then
		profile = "animehd30"
	elseif width == 1280 and path:find("Videos/Anime/") and fps < 31 then
		profile = "animehd30"
	elseif height == 480 and path:find("Videos/Anime/") then
		profile = "animesd"
	end

	mp.osd_message("Applied Profile: " .. profile, 3)
end

-- Register the function to run when a video is loaded
mp.register_event("file-loaded", show_profile)
