local tokyo_status_ok, tokyo = pcall(require, "tokyonight")
if not tokyo_status_ok then
  return
end

local util = require("tokyonight.util")

tokyo.setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  sidebars = { "qf", "help", "terminal", "packer" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end,
  on_highlights = function(hl, c)
    local bg_highlight = util.blend(c.bg_highlight, "#1a1b26", 0.3)
    hl.CursorLine = {
      bg = bg_highlight,
    }
    hl.CursorLineNr = {
      fg = c.dark5,
      bold = true,
    }
    hl.ColorColumn = {
      bg = bg_highlight,
    }
  end,
})

vim.cmd([[colorscheme tokyonight]])
