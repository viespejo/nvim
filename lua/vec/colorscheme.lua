-- local colorscheme = "default"
local colorscheme = "tokyonight"

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- custom cursorline and colorcolumn
local colors = require("tokyonight.colors").setup({})
local util = require("tokyonight.util")
-- print(vim.inspect(colors))
local bg_highlight = util.blend(colors.bg_highlight, '#1a1b26', 0.3)
vim.cmd("highlight! CursorLine cterm=underline guibg=" .. bg_highlight)
vim.cmd("highlight! CursorLineNr guifg=" .. colors.dark5 .. ",bold")
vim.cmd("highlight! ColorColumn ctermbg=lightgrey guibg=" .. bg_highlight)
