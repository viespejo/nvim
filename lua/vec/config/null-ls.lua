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
  debug = false,
  sources = {
    diagnostics.golangci_lint,
    formatting.goimports,
    formatting.prettier.with({
      -- extra_args = function(params)
      --   local filetype = vim.api.nvim_buf_get_option(params.bufnr, "filetype")
      --
      --   local filetypes = {
      --     javascript = true,
      --     javascriptreact = true,
      --     typescript = true,
      --     typescriptreact = true,
      --   }
      --
      --   if filetypes[filetype] then
      --   	return { "--parser", "typescript" }
      --   end
      --
      --   return {}
      -- end,
      prefer_local = "node_modules/.bin",
    }),
    formatting.black,
    diagnostics.flake8.with({
      extra_args = { "--ignore=E501,E203" },
      filetypes = { "python" },
    }),
    -- formatting.yapf,
    formatting.stylua,
    diagnostics.stylelint,
    formatting.stylelint,
    diagnostics.eslint,
    code_actions.eslint,
    -- diagnostics.eslint,
    require("typescript.extensions.null-ls.code-actions"),
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      -- with formatting capability we format when saving
      vim.cmd([[
        augroup vec_lsp_formatting
          au! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        augroup END
      ]])
    end
  end,
  root_dir = u.root_pattern(".null-ls-root", ".venv", "go.mod", "Makefile", ".git"),
})
