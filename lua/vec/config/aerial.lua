require("aerial").setup()

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<cr>", { noremap = true, silent = true })
