local g = vim.g

-- speed starttime

require("impatient")
-- vim.loader.enable()

-- disable some built-in plugins we don't want
local disabled_built_ins = {
	"gzip",
	"man",
	"matchit",
	"matchparen",
	--  'shada_plugin',
	"tarPlugin",
	"tar",
	"zipPlugin",
	"zip",
	-- "netrw",
	-- "netrwPlugin",
}

for k, _ in pairs(disabled_built_ins) do
	g["loaded_" .. disabled_built_ins[k]] = 1
end

require("vec.options")
require("vec.keymaps")
require("vec.plugins")
require("vec.colorscheme")
-- require("vec.filetypes")
require("vec.autocommands")
