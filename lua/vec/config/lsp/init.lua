local status_ok, lsp_config = pcall(require, "lspconfig")
if not status_ok then
  return
end

local handlers_status_ok, handlers = pcall(require, "vec.config.lsp.handlers")
if not handlers_status_ok then
  return
end

--Enable (broadcasting) snippet capability for completion
local snippets_capabilities = vim.lsp.protocol.make_client_capabilities()
snippets_capabilities.textDocument.completion.completionItem.snippetSupport = true

-- manual servers
-- we don't use mason for them
local servers = {
  gopls = {
    disable_diagnostics = false,
    cmd = { "gopls", "serve" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  cssls = {
    snippets_for_completion = true,
    settings = {
      css = { validate = false, lint = { unknownAtRules = "ignore" } },
      scss = { validate = true },
      less = { validate = true },
    },
  },
  html = { snippets_for_completion = true },
  jsonls = require("vec.config.lsp.settings.jsonls"),
  --  eslint = {},
}

local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

for server, config in pairs(servers) do
  if type(config) == "function" then
    config = config()
  end
  if config.snippets_for_completion then
    config.capabilities = snippets_capabilities
  end
  if config.disable_diagnostics then
    config.handlers = {
      ["textDocument/publishDiagnostics"] = function()
      end,
    }
  end
  local new_opts = vim.tbl_deep_extend("force", opts, config)
  -- print("Setting up " .. server .. " with opts: " .. vim.inspect(new_opts))
  lsp_config[server].setup(new_opts)
end

-- require("vec.config.lsp.lsp-installer")
require("vec.config.lsp.mason")

handlers.setup()
