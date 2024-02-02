local ok, ip = pcall(require, "icon-picker")
if not ok then
  return
end

ip.setup({
  disable_legacy_commands = true,
})

-- vim.api.nvim_set_keymap("i", "þ", "<ESC>:IconPickerInsert<cr>", { noremap = true, silent = true })
