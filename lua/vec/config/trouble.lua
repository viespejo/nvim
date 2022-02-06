local ok, trouble = pcall(require, "trouble")
if not ok then
	return
end

trouble.setup({})

local utils = require("vec.config.utils")
require("trouble").action("on_win_enter")
utils.map("n", "[Space]t", ":TroubleToggle<cr>", { noremap = true, silent = true })
vim.cmd([[au FileType Trouble setlocal statusline=\ \ Trouble]])
