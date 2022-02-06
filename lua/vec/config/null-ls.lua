local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
local u = require("null-ls.utils")

null_ls.setup({
	-- debug = false,
	sources = {
		diagnostics.golangci_lint,
		formatting.goimports,
		formatting.prettier.with({
			-- extra_args = { "--parser", "typescript" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"html",
			},
			prefer_local = "node_modules/.bin",
		}),
		-- formatting.black.with { extra_args = { "--fast" } },
		-- formatting.yapf,
		formatting.stylua,
		diagnostics.stylelint.with({ prefer_local = "node_modules/.bin" }),
		formatting.stylelint.with({ prefer_local = "node_modules/.bin" }),
		diagnostics.eslint.with({ prefer_local = "node_modules/.bin" }),
		code_actions.eslint.with({ prefer_local = "node_modules/.bin" }),
		-- diagnostics.eslint,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			-- with formatting capability we format when saving
			vim.cmd([[
        augroup vec_lsp_formatting
          au! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 3000)
        augroup END
      ]])
		end
	end,
	root_dir = u.root_pattern(".null-ls-root", "go.mod", "Makefile", ".git"),
})
