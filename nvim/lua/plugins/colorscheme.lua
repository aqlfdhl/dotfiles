return {
  -- Add the Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Ensure it loads at startup
    priority = 1000, -- Ensure it loads before other plugins
    opts = {
      style = "night", -- Options: "storm", "night", or "day"
      transparent = true, -- Optional: Enable transparent background
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Configure LazyVim to use Tokyo Night
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight", -- Use the main group name
    },
  },
}
