-- vim: set sw=2 ts=2 sts=2 foldmethod=marker:
-- it's loading from plugin/dap.vim
local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  return
end
dap.set_log_level("DEBUG")

-- php {{{

require("vec.config.dap.php")

-- }}}

-- go {{{

require("vec.config.dap.go").setup()

-- }}}

-- dapui
local ok_dapui, dapui = pcall(require, "dapui")
if not ok_dapui then
  return
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>", "za" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        { id = "stacks", size = 0.40 },
        { id = "breakpoints", size = 0.30 },
        { id = "watches", size = 00.30 },
      },
      size = 10, -- 10 columns
      position = "bottom",
    },
    {
      elements = {
        "repl",
      },
      size = 60,
      position = "right",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

dap.listeners.after["event_initialized"]["dapui_config"] = function()
  -- dapui.open('tray')
  print("Session started")
end
dap.listeners.before["command_disconnect"]["dapui_config"] = function()
  -- dapui.close()
  print("Session terminated")
end

-- dap virtual text
require("nvim-dap-virtual-text").setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = true, -- prefix virtual text with comment string
  -- experimental features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = 80, -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})
