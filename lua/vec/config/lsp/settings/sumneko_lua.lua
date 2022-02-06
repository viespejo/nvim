local function library()
  local ret = {}

  local function add(lib)
    for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
      p = vim.loop.fs_realpath(p)
      table.insert(ret, p)
    end
  end

  add("$VIMRUNTIME")
  for _, site in pairs(vim.split(vim.o.packpath, ",")) do
    add(site .. "/pack/*/opt/*")
    add(site .. "/pack/*/start/*")
  end
  return ret
end

local function path()
  local p = {}
  table.insert(p, "?.lua")
  table.insert(p, "?/init.lua")
  return p
end

return {
  on_new_config = function(config, root_dir)
    -- remove the root_dir from the workspace, otherwise diagnostics break. See #21
    -- Should no longer be needed with workspace.nvim
    local lib = vim.tbl_deep_extend("force", {}, config.settings.Lua.workspace.library)
    lib[vim.loop.fs_realpath(root_dir) .. "/lua"] = nil
    lib[vim.loop.fs_realpath(root_dir)] = nil
    config.settings.Lua.workspace.library = lib
    return config
  end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = path(),
      },
      completion = { callSnippet = "Replace" },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      -- hint = { enable = true },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = library(),
        maxPreload = 1000,
        preloadFileSize = 150,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

-- return {
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("lua", true),
--       },
--     },
--   },
-- }
