local options = {
	shader_path = "~~/shaders",
	shader_profiles = "",
	include_none_shader_profile = true,
	include_default_shader_profile = true,
	default_shader_profile_name = "Default",

	color_profiles = "",
	include_default_color_profile = true,
	default_color_profile_name = "Default",

	brightness_increment = 0.25,
	contrast_increment = 0.25,
	saturation_increment = 0.25,
	gamma_increment = 0.25,
	hue_increment = 0.25,
}

local script_name = mp.get_script_name()
mp.utils = require("mp.utils")
mp.options = require("mp.options")
mp.options.read_options(options, "uosc-video-settings", function() end)

local function command(str)
	return string.format("script-message-to %s %s", script_name, str)
end

local default_property = {
	["brightness"] = mp.get_property_number("brightness"),
	["contrast"] = mp.get_property_number("contrast"),
	["saturation"] = mp.get_property_number("saturation"),
	["gamma"] = mp.get_property_number("gamma"),
	["hue"] = mp.get_property_number("hue"),
}

local profile = {
	color = {},
	shader = {},
}

local menu = {
	color = nil,
	shader = nil,
}

local function create_property_number_adjustment(title, property, increment, min, max)
	local current_value = mp.get_property_number(property)

	local function create_adjustment_actions()
		local range = ""
		if min or max then
			range = " " .. (min or "") .. (max and " " .. max or "")
		end
		return {
			{
				name = command("adjust-property " .. property .. " " .. increment .. range),
				icon = "add",
				label = "Increase by " .. increment .. ".",
			},
			{
				name = command("adjust-property " .. property .. " -" .. increment .. range),
				icon = "remove",
				label = "Decrease by " .. increment .. ".",
			},
			{
				name = command("adjust-property " .. property .. " reset"),
				icon = "clear",
				label = "Reset.",
			},
		}
	end

	return {
		title = title,
		hint = tostring(current_value),
		actions = create_adjustment_actions(),
		actions_place = "outside",
	}
end

local function create_menu_data()
	local menu_items = {}

	table.insert(menu_items, menu.color)
	table.insert(menu_items, menu.shader)

	return {
		type = "video_settings",
		--		title = "Video settings",
		items = menu_items,
		search_submenus = true,
		keep_open = true,
		callback = { script_name, "menu-event" },
	}
end

local function update_menu()
	local json = mp.utils.format_json(create_menu_data())
	mp.commandv("script-message-to", "uosc", "update-menu", json)
end

-- Color
local function create_color_profiles()
	if options.include_default_color_profile then
		table.insert(profile.color, {
			title = options.default_color_profile_name:match("^%s*(.-)%s*$"),
			active = false,
			value = command(
				"adjust-color profile "
					.. default_property["brightness"]
					.. ","
					.. default_property["contrast"]
					.. ","
					.. default_property["saturation"]
					.. ","
					.. default_property["gamma"]
					.. ","
					.. default_property["hue"]
			),
			brightness = tonumber(default_property["brightness"]),
			contrast = tonumber(default_property["contrast"]),
			saturation = tonumber(default_property["saturation"]),
			gamma = tonumber(default_property["gamma"]),
			hue = tonumber(default_property["hue"]),
			id = "profile",
		})
	end

	for color_profile in options.color_profiles:gmatch("([^;]+)") do
		local name, settings = color_profile:match("(.+):(.+)")
		if name and settings then
			local brightness, contrast, saturation, gamma, hue =
				settings:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
			if brightness and contrast and saturation and gamma and hue then
				table.insert(profile.color, {
					title = name:match("^%s*(.-)%s*$"),
					active = false,
					value = command(
						"adjust-color profile "
							.. brightness
							.. ","
							.. contrast
							.. ","
							.. saturation
							.. ","
							.. gamma
							.. ","
							.. hue
					),
					brightness = tonumber(brightness),
					contrast = tonumber(contrast),
					saturation = tonumber(saturation),
					gamma = tonumber(gamma),
					hue = tonumber(hue),
					id = "profile",
				})
			end
		end
	end

	table.insert(profile.color, {
		title = "Custom",
		active = false,
		selectable = false,
		muted = true,
		value = command("adjust-color clear"),
		id = "custom",
	})
end

local function create_color_menu()
	local color_items = {}

	local brightness = mp.get_property_number("brightness")
	local contrast = mp.get_property_number("contrast")
	local saturation = mp.get_property_number("saturation")
	local gamma = mp.get_property_number("gamma")
	local hue = mp.get_property_number("hue")
	local is_original = brightness == 0 and contrast == 0 and saturation == 0 and gamma == 0 and hue == 0

	local profile_match = false

	for _, item in ipairs(profile.color) do
		if item.id == "profile" then
			local is_active = brightness == item.brightness
				and contrast == item.contrast
				and saturation == item.saturation
				and gamma == item.gamma
				and hue == item.hue

			if is_active then
				profile_match = true
				item.value = command("adjust-color clear")
				default_property["brightness"] = brightness
				default_property["contrast"] = contrast
				default_property["saturation"] = saturation
				default_property["gamma"] = gamma
				default_property["hue"] = hue
			else
				item.value = command(
					"adjust-color profile "
						.. item.brightness
						.. ","
						.. item.contrast
						.. ","
						.. item.saturation
						.. ","
						.. item.gamma
						.. ","
						.. item.hue
				)
			end

			item.active = is_active
		end

		if item.id == "custom" then
			item.active = not is_original and not profile_match
			item.selectable = not is_original and not profile_match
			item.muted = is_original or profile_match
		end

		table.insert(color_items, item)
	end

	if #color_items > 0 then
		color_items[#color_items].separator = true
	end

	local color_properties = { "brightness", "contrast", "saturation", "gamma", "hue" }

	for _, prop in ipairs(color_properties) do
		table.insert(
			color_items,
			create_property_number_adjustment(prop:gsub("^%l", string.upper), prop, options[prop .. "_increment"])
		)
	end

	menu.color = {
		title = "Color",
		items = color_items,
	}

	update_menu()
end

-- Shaders
local function create_shader_profiles()
	if options.include_default_shader_profile then
		table.insert(profile.shader, {
			title = options.default_shader_profile_name:match("^%s*(.-)%s*$"),
			active = false,
			value = command("adjust-shaders profile " .. table.concat(mp.get_property_native("glsl-shaders", {}), ",")),
			profshaders = table.concat(mp.get_property_native("glsl-shaders", {}), ","),
			id = "profile",
		})
	end

	for shader_profile in options.shader_profiles:gmatch("([^;]+)") do
		local name, shaders = shader_profile:match("(.+):(.+)")
		if name and shaders then
			name = name:match("^%s*(.-)%s*$")
			local shader_list = {}
			for shader in shaders:gmatch("([^,]+)") do
				local trimmed_shader = shader:match("^%s*(.-)%s*$")
				if trimmed_shader ~= "" then
					table.insert(shader_list, trimmed_shader)
				end
			end
			local prof_shaders = table.concat(shader_list, ",")
			table.insert(profile.shader, {
				title = name,
				active = false,
				value = command("adjust-shaders profile " .. prof_shaders),
				profshaders = prof_shaders,
				id = "profile",
			})
		end
	end

	table.insert(profile.shader, {
		title = "Custom",
		active = false,
		selectable = false,
		muted = true,
		value = command("adjust-shaders clear"),
		id = "custom",
	})
end

local function create_shader_menu(value)
	local shader_items = {}

	local current_shaders = value

	local function create_shader_adjustment_actions(shader_path, index)
		local actions = {}

		if index > 1 then
			table.insert(actions, {
				name = command("move-shader " .. shader_path .. " up"),
				icon = "keyboard_arrow_up",
				label = "Move up.",
			})
		end
		if index < #current_shaders then
			table.insert(actions, {
				name = command("move-shader " .. shader_path .. " down"),
				icon = "keyboard_arrow_down",
				label = "Move down.",
			})
		end

		table.insert(actions, {
			name = command("adjust-shaders toggle " .. ("%q"):format(shader_path)),
			icon = "clear",
			label = "Remove.",
		})
		return actions
	end

	local function compare_shaders(shaders1, shaders2)
		if #shaders1 ~= #shaders2 then
			return false
		end
		for i, shader in ipairs(shaders1) do
			if shader ~= shaders2[i] then
				return false
			end
		end
		return true
	end

	local profile_match = false

	for _, item in ipairs(profile.shader) do
		if item.id == "profile" then
			local profile_shader = {}
			for shader in item.profshaders:gsub('"', ""):gmatch("([^,]+)") do
				table.insert(profile_shader, shader)
			end

			local is_active = compare_shaders(current_shaders, profile_shader)

			if is_active then
				profile_match = true
				item.value = command("adjust-shaders clear")
			else
				item.value = command("adjust-shaders profile " .. item.profshaders)
			end

			item.active = is_active
		end

		if item.id == "custom" then
			item.active = #current_shaders > 0 and not profile_match
			item.selectable = #current_shaders > 0 and not profile_match
			item.muted = #current_shaders == 0 or profile_match
		end

		table.insert(shader_items, item)
	end

	if #shader_items > 0 then
		shader_items[#shader_items].separator = true
	end

	local active_shader_items = {}
	local is_active = {}

	for i, shader_path in ipairs(current_shaders) do
		is_active[shader_path] = true
		local _, shader_name = mp.utils.split_path(shader_path)
		table.insert(active_shader_items, {
			title = shader_name:match("(.+)%..+$") or shader_name,
			hint = string.format("%d", i) or nil,
			actions = create_shader_adjustment_actions(shader_path, i),
			actions_place = "outside",
		})
	end

	table.insert(shader_items, {
		title = "Active",
		items = active_shader_items,
		separator = true,
	})

	local function listShaderFiles(path, option_path)
		local dir_items = {}
		local is_original_path = path == mp.command_native({ "expand-path", options.shader_path })

		local _, current_dir = mp.utils.split_path(path)

		if not is_original_path then
			option_path = option_path:gsub("/+$", "") .. "/" .. current_dir
		end

		local shader_files = mp.utils.readdir(path, "files")
		if shader_files ~= nil then
			for i, shader_file in ipairs(shader_files) do
				shader_files[i] = mp.utils.join_path(option_path, shader_file)
			end
			for i, shader_path in ipairs(shader_files) do
				local _, shader = mp.utils.split_path(shader_path)
				table.insert(dir_items, {
					title = shader:match("(.+)%..+$") or shader,
					icon = is_active[shader_path] and "check_box" or "check_box_outline_blank",
					value = command("adjust-shaders toggle " .. ("%q"):format(shader_path)),
				})
			end
		end

		local shader_dirs = mp.utils.readdir(path, "dirs")
		if shader_dirs then
			for _, folder in ipairs(shader_dirs) do
				local nextPath = mp.command_native({ "expand-path", mp.utils.join_path(path, folder) })
				local subdir_items = listShaderFiles(nextPath, option_path)
				local subdir = {
					title = folder,
					items = subdir_items,
				}

				table.insert(dir_items, subdir)
			end
		end
		return dir_items
	end

	for _, item in
		ipairs(listShaderFiles(mp.command_native({ "expand-path", options.shader_path }), options.shader_path))
	do
		table.insert(shader_items, item)
	end
	menu.shader = {
		title = "Shaders",
		items = shader_items,
	}

	update_menu()
end

-- Message Handlers
local message_handlers = {
	["menu-event"] = function(json)
		local event = mp.utils.parse_json(json)
		if event.action ~= nil then
			mp.command(event.action)
		elseif event.value ~= nil then
			mp.command(event.value)
		end
	end,
	["adjust-color"] = function(property, value)
		if property == "profile" then
			local brightness, contrast, saturation, gamma, hue = value:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
			if brightness and contrast and saturation and gamma and hue then
				mp.set_property("brightness", tonumber(brightness))
				mp.set_property("contrast", tonumber(contrast))
				mp.set_property("saturation", tonumber(saturation))
				mp.set_property("gamma", tonumber(gamma))
				mp.set_property("hue", tonumber(hue))
			end
		else
			if property == "clear" then
				mp.set_property("brightness", 0)
				mp.set_property("contrast", 0)
				mp.set_property("saturation", 0)
				mp.set_property("gamma", 0)
				mp.set_property("hue", 0)
			elseif property == "reset" then
				mp.set_property(value, default_property[value])
			else
				local current = mp.get_property_number(property)
				local num_value = tonumber(value)
				local new_value = current + num_value
				new_value = math.max(-100, math.min(100, new_value))
				mp.set_property(property, new_value)
			end
		end
	end,
	["toggle-property"] = function(property)
		mp.set_property(property, not mp.get_property_bool(property) and "yes" or "no")
	end,

	["adjust-property"] = function(property, value, min, max)
		min = min or -math.huge
		max = max or math.huge
		local num_value = tonumber(value)
		if num_value then
			local current = mp.get_property_number(property)
			local new_value = current + num_value
			new_value = math.max(min, math.min(max, new_value))
			mp.set_property(property, new_value)
		else
			if value == "reset" then
				mp.set_property(property, default_property[property])
			else
				mp.set_property(property, value)
			end
		end
	end,
	["adjust-shaders"] = function(property, value)
		if property == "toggle" then
			local shader_path = value
			mp.commandv("change-list", "glsl-shaders", "toggle", shader_path)
		elseif property == "clear" then
			mp.set_property_native("glsl-shaders", {})
		elseif property == "profile" then
			local profile_shaders = {}
			local shader_list = value
			if shader_list and shader_list ~= "" then
				for shader in shader_list:gmatch("([^,]+)") do
					local trimmed_shader = shader:match("^%s*(.-)%s*$")
					if trimmed_shader ~= "" then
						table.insert(profile_shaders, trimmed_shader)
					end
				end
			end
			mp.set_property_native("glsl-shaders", profile_shaders)
		end
	end,
	["move-shader"] = function(shader, dir)
		local current_shaders = mp.get_property_native("glsl-shaders", {})

		-- Used AI for this one lol
		local function moveStringInList(list, target, direction)
			-- Create a new list by copying all elements
			local newList = {}
			for i, str in ipairs(list) do
				newList[i] = str
			end

			-- Find the index of the target string
			local index = -1
			for i, str in ipairs(newList) do
				if str == target then
					index = i
					break
				end
			end

			-- If string not found, return the new copy of the list
			if index == -1 then
				return newList
			end

			-- Handle moving up (left)
			if direction == "up" or direction == "left" then
				-- If already at the start, return new list without changes
				if index == 1 then
					return newList
				end
				-- Swap with previous element
				newList[index], newList[index - 1] = newList[index - 1], newList[index]

				-- Handle moving down (right)
			elseif direction == "down" or direction == "right" then
				-- If already at the end, return new list without changes
				if index == #newList then
					return newList
				end
				-- Swap with next element
				newList[index], newList[index + 1] = newList[index + 1], newList[index]
			end

			return newList
		end

		mp.set_property_native("glsl-shaders", moveStringInList(current_shaders, shader, dir))
	end,
}

-- Setup Functions
local function setup_message_handlers()
	for message, handler in pairs(message_handlers) do
		mp.register_script_message(message, handler)
	end
end

local function setup_property_observers()
	mp.observe_property("brightness", "number", create_color_menu)
	mp.observe_property("contrast", "number", create_color_menu)
	mp.observe_property("saturation", "number", create_color_menu)
	mp.observe_property("gamma", "number", create_color_menu)
	mp.observe_property("hue", "number", create_color_menu)
	mp.observe_property("glsl-shaders", "native", function(name, value)
		create_shader_menu(value)
	end)
end

local function init()
	create_color_profiles()
	create_shader_profiles()

	setup_message_handlers()
	setup_property_observers()

	mp.add_key_binding(nil, "open-menu", function()
		local json = mp.utils.format_json(create_menu_data())
		mp.commandv("script-message-to", "uosc", "open-menu", json)
	end)
end

init()
