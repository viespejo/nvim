-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup({
  -- on_attach = my_on_attach,
  hijack_netrw = false,
  view = {
    width = {},
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
    -- update_cwd = false,
    -- ignore_list = {},
  },
  renderer = {
    root_folder_label = function(path)
      path = vim.fn.fnamemodify(path, ":~")
      local parent_path = vim.fn.fnamemodify(path, ":h")
      local last_dir = vim.fn.fnamemodify(path, ":t")
      return parent_path:gsub("([a-zA-Z])[a-z]+", "%1") .. "/" .. last_dir
    end,
  },
})

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd("quit")
    end
  end,
})

vim.cmd([[au BufEnter NvimTree setlocal statusline=\ \ NvimTree]])
vim.cmd([[hi NvimTreeRootFolder gui=bold guifg=#f7768e]])
