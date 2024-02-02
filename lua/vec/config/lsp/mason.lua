local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local default_opts = {
  on_attach = require("vec.config.lsp.handlers").on_attach,
  capabilities = require("vec.config.lsp.handlers").capabilities,
}

mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    -- print("Setting up " .. server_name)
    -- print("Opts " .. vim.inspect(default_opts))
    lspconfig[server_name].setup(default_opts)
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  ["clangd"] = function()
    local clangd_opts = vim.tbl_deep_extend("force", {}, default_opts)
    clangd_opts.capabilities.offsetEncoding = { "utf-16" }
    clangd_opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    lspconfig.clangd.setup(clangd_opts)
  end,
  ["tsserver"] = function()
    require("typescript").setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false,         -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true,     -- fall back to standard LSP definition on failure
      },
      server = default_opts,
    })
    -- local tsserver_opts = vim.tbl_deep_extend("force", {}, default_opts)
    -- local commands = tsserver_opts.commands or {}
    -- commands.OrganizationImport = {
    --   function()
    --     local params = {
    --       command = "_typescript.organizeImports",
    --       arguments = { vim.api.nvim_buf_get_name(0) },
    --       title = "",
    --     }
    --
    --     vim.lsp.buf.execute_command(params)
    --   end,
    --   description = "Organize Imports",
    -- }
    --
    -- tsserver_opts.commands = commands

    -- lspconfig.tsserver.setup(tsserver_opts)
  end,
})
