-- =============================================================
-- keybindings.lua
-- Hyprland keybindings module
-- Usage: require("keybindings").setup(hl, opts)
-- =============================================================

local M = {}

-- ── Default configuration ──────────────────────────────────────
local defaults = {
	mod = "SUPER",
	terminal = "kitty",
	file_manager = "thunar",
	browser = "firefox",
	menu = "rofi",
	screenshot_dir = os.getenv("HOME") .. "/Pictures/Screenshots",
}

-- ── Internal helpers ───────────────────────────────────────────
local function bind_app_launchers(hl, cfg)
	local mod = cfg.mod
	hl.bind(mod .. " + T", hl.dsp.exec_cmd(cfg.terminal))
	hl.bind(mod .. " + E", hl.dsp.exec_cmd("kitty yazi"))
	hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd(cfg.file_manager))
	hl.bind(mod .. " + B", hl.dsp.exec_cmd(cfg.browser))
end

local function bind_rofi(hl, cfg)
	local mod = cfg.mod
	hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/vertical.rasi"))
	hl.bind(mod .. " + escape", hl.dsp.exec_cmd("~/.config/hypr/sh-scripts/quickaction.sh"))
	hl.bind(mod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/sh-scripts/appearance.sh"))
	hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("~/.config/hypr/sh-scripts/screenshot.sh"))
	hl.env("HYPRSHOT_DIR", cfg.screenshot_dir)
end

local function bind_window_management(hl, cfg)
	local mod = cfg.mod
	hl.bind(mod .. " + Q", hl.dsp.window.close())
	hl.bind(mod .. " + F", hl.dsp.window.float({ action = "toggle" }))
	hl.bind(mod .. " + R", hl.dsp.exec_cmd(cfg.menu))
	hl.bind(mod .. " + P", hl.dsp.window.pseudo())
	hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))
	hl.bind(mod .. " + F11", hl.dsp.window.fullscreen({ action = "toggle" }))

	-- Focus movement
	for _, dir in ipairs({ "left", "right", "up", "down" }) do
		hl.bind(mod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
		hl.bind(mod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
	end

	-- Drag & resize with mouse
	hl.bind(mod .. " + C", hl.dsp.window.drag(), { mouse = true })
	hl.bind(mod .. " + r", hl.dsp.window.resize(), { mouse = true })
end

local function bind_workspaces(hl, cfg)
	local mod = cfg.mod
	for i = 1, 10 do
		local key = i % 10 -- 10 → key "0"
		hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
		hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end

	-- Special / scratchpad workspace
	hl.bind(mod .. " + X", hl.dsp.workspace.toggle_special("magic"))
	hl.bind(mod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:magic" }))

	-- Scroll through workspaces
	hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
	hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
end

local function bind_media_keys(hl)
	local locked_repeat = { locked = true, repeating = true }
	local locked = { locked = true }

	-- Volume
	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), locked_repeat)
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), locked_repeat)
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked_repeat)
	hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked_repeat)

	-- Brightness
	hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), locked_repeat)
	hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), locked_repeat)

	-- Playerctl
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
	hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
end

local function bind_system(hl, cfg)
	local mod = cfg.mod

	-- Lock screen
	hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"))

	-- Lid close → lock + suspend
	hl.bind("switch:on:Lid Switch", function()
		hl.dispatch(hl.dsp.exec_cmd("hyprlock --immediate"))
		hl.dispatch(hl.dsp.exec_cmd("systemctl suspend"))
	end, { locked = true })
end

-- ── Public API ─────────────────────────────────────────────────
--- Register all keybindings.
--- @param hl      table   The Hyprland Lua API object
--- @param opts    table?  Optional overrides for `defaults`
function M.setup(hl, opts)
	local cfg = {}
	for k, v in pairs(defaults) do
		cfg[k] = v
	end
	if opts then
		for k, v in pairs(opts) do
			cfg[k] = v
		end
	end

	bind_app_launchers(hl, cfg)
	bind_rofi(hl, cfg)
	bind_window_management(hl, cfg)
	bind_workspaces(hl, cfg)
	bind_media_keys(hl)
	bind_system(hl, cfg)
end

return M
