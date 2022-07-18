local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
	return
end

function _G.snippets_clear()
	--for m, _ in pairs(luasnip.snippets) do
	--	package.loaded["snippets." .. m] = nil
	--end
	luasnip.snippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, "snippets." .. k)
			if not ok and not string.match(m, "^module.*not found:") then
				error(m)
			end
			t[k] = ok and m or {}

			-- optionally load snippets from vscode- or snipmate-library:
			--
			-- require("luasnip.loaders.from_vscode").load({ include = { k } })
			-- require("luasnip.loaders.from_snipmate").load({include={k}})
			return t[k]
		end,
	})
end

_G.snippets_clear()

vim.cmd([[
augroup snippets_clear
au!
au BufWritePost ]] .. vim.fn.stdpath("config") .. [[config~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
augroup END
]])

function _G.edit_ft()
	-- returns table like {"lua", "all"}
	local fts = require("luasnip.util.util").get_snippet_filetypes()
	vim.ui.select(fts, {
		prompt = "Select which filetype to edit:",
	}, function(item, idx)
		-- selection aborted -> idx == nil
		if idx then
			vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/snippets/" .. item .. ".lua")
		end
	end)
end

vim.cmd([[command! LuaSnipEdit :lua _G.edit_ft()]])

-- luasnip.filetype_set("javascript", { "javascriptreact" })
require("luasnip.loaders.from_vscode").lazy_load()
