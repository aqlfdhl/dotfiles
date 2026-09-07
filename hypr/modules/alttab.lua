hl.config({
	plugin = {
		scrolloverview = {
			gesture_distance = 300, -- how far is the "max" for the gesture
			scale = 0.5, -- preferred overview scale
			workspace_gap = 10,
			layout = "vertical", -- vertical or horizontal
			wallpaper = 0, -- 0: global only, 1: per-workspace only, 2: both
			blur = false, -- blur only the main overview wallpaper

			shadow = {
				enabled = false,
				range = 50,
			},
		},
	},
})

local M = {}

local openedByAltTab = false

local function object_value(value, key)
	if value == nil then
		return nil
	end

	local ok, result = pcall(function()
		return value[key]
	end)

	return ok and result or nil
end

local function selection_state()
	local workspaceId = object_value(hl.get_active_workspace(), "id")
	local windowAddress = object_value(hl.get_active_window(), "address")
	return tostring(workspaceId) .. ":" .. tostring(windowAddress)
end

local function navigate_to_first_column()
	local previousState
	local maxSteps = #(hl.get_windows() or {}) + #(hl.get_workspaces() or {}) + 1

	for _ = 1, maxSteps do
		local currentState = selection_state()
		if currentState == previousState then
			return
		end

		previousState = currentState
		hl.plugin.scrolloverview.navigate("up")
	end
end

local function navigate_next_column()
	local previousState = selection_state()
	hl.plugin.scrolloverview.navigate("down")

	if selection_state() == previousState then
		navigate_to_first_column()
	end
end

function M.next()
	hl.plugin.scrolloverview.overview("on")
	openedByAltTab = true
	navigate_next_column()
end

function M.close()
	if openedByAltTab then
		hl.plugin.scrolloverview.overview("off")
		openedByAltTab = false
	end
end

return M
