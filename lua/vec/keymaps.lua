local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local command_opts = { noremap = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = ""
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal -- {{{

-- smart space mapping
keymap("n", "<Space>", "[Space]", {})
keymap("n", "[Space]", "<Nop>", opts)

-- Edit nvim config dir and file
keymap("n", "<leader>ev", [[:edit <c-r>=stdpath('config')<cr><cr>]], opts)
keymap("n", "<leader>evo", [[:edit <c-r>=stdpath('config')<cr>/lua/vec/options.lua<cr>]], opts)
keymap("n", "<leader>evm", [[:edit <c-r>=stdpath('config')<cr>/lua/vec/keymaps.lua<cr>]], opts)
keymap("n", "<leader>evp", [[:edit <c-r>=stdpath('config')<cr>/lua/vec/plugins.lua<cr>]], opts)
keymap("n", "<leader>evc", [[:edit <c-r>=stdpath('config')<cr>/lua/vec/config/cmp.lua<cr>]], opts)
keymap("n", "<leader>evl", [[:edit <c-r>=stdpath('config')<cr>/lua/vec/config/lsp<cr>]], opts)

-- Delete buffer
keymap("n", "Q", ":bd<cr>", opts)

-- Move text up and down
keymap("n", "<m-j>", "<esc>:m .+1<cr>==", opts)
keymap("n", "<m-k>", "<esc>:m .-2<cr>==", opts)

-- Better window navigation
keymap("n", "<leader>w", "<c-w>", opts)
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)

-- Resize with arrows
keymap("n", "<m-Up>", ":resize -1<cr>", opts)
keymap("n", "<m-Down>", ":resize +1<cr>", opts)
keymap("n", "<m-Left>", ":vertical resize -1<cr>", opts)
keymap("n", "<m-Right>", ":vertical resize +1<cr>", opts)

-- Navigate buffers
keymap("n", "<m-n>", ":bn<cr>", opts)
keymap("n", "<m-p>", ":bp<cr>", opts)
keymap("n", "<leader>3", ":b#<cr>", opts)

-- Navigate tabs
keymap("n", "<m-h>", ":tabprevious<cr>", opts)
keymap("n", "<m-l>", ":tabnext<cr>", opts)

-- Open netwr on directory of the current file
keymap("n", "<leader>e.", ":e %:p:h<cr>", opts)
-- Open netwr on pwd directory
keymap("n", "<leader>ee", ":e.<cr>", opts)

-- nvimtree
keymap("n", "[Space]e", ":NvimTreeToggle<cr>", opts)
keymap("n", "[Space]E", ":NvimTreeOpen .<cr>", opts)

-- helper to edit mode
keymap("n", "<leader>ew", ":e %%", {})

-- toggle wrap
keymap("n", "[Space]w", ":set wrap!<cr>", opts)

-- quickfix and location list
keymap("n", "<leader>qo", ":copen<cr>", opts)
keymap("n", "<leader>qc", ":cclose<cr>", opts)
keymap("n", "<leader>qn", ":cnext<cr>zz", opts)
keymap("n", "<leader>qp", ":cprev<cr>zz", opts)
keymap("n", "<leader>qgg", ":cfirst<cr>zz", opts)
keymap("n", "<leader>qG", ":clast<cr>zz", opts)
keymap("n", "<leader>lo", ":lopen<cr>", opts)
keymap("n", "<leader>lc", ":lclose<cr>", opts)
keymap("n", "<leader>ln", ":lnext<cr>zz", opts)
keymap("n", "<leader>lp", ":lprev<cr>zz", opts)
keymap("n", "<leader>lgg", ":lfirst<cr>zz", opts)
keymap("n", "<leader>lG", ":llast<cr>zz", opts)

-- selecting text you just pasted
keymap("n", "gv", "'`[' . strpart(getregtype(), 0, 1) . '`]'", { noremap = true, expr = true })

-- turn highlighted matches off but it does not change hlsearch option
keymap("n", "<leader>/", ":nohlsearch<cr>", opts)

-- }}}

-- Insert -- {{{

-- i_ctrlx_ctrlf
keymap("i", "<c-f>", "<c-x><c-f>", { noremap = true })

-- -- }}}

-- Visual -- {{{

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<m-j>", ":m .+1<cr>==", opts)
keymap("v", "<m-k>", ":m .-2<cr>==", opts)

-- copy whith losing register
--keymap("v", "p", '"-dP', opts)

-- -- }}}

-- Visual Block -- {{{

-- -- Move text up and down
keymap("x", "<m-j>", ":move '>+1<cr>gv-gv", opts)
keymap("x", "<m-k>", ":move '<-2<cr>gv-gv", opts)

-- -- }}}

-- Command -- {{{

-- change annoying typo in command mode
keymap("c", "W", "w", command_opts)
keymap("c", "Wq", "wq", command_opts)
keymap("c", "WQ", "wq", command_opts)

-- change Working Directory to that of the current file
keymap("c", "cd.", "lcd %:p:h", command_opts)

-- for when you forget to sudo.. Really Write the file.
keymap("c", "w!!", "w !sudo -S tee % >/dev/null", command_opts)

-- helper to edit mode
keymap("c", "%%", "<c-r>=expand('%:h')<cr>", command_opts)

-- -- }}}

-- Terminal -- {{{

-- Better terminal navigation
keymap("t", "<leader><esc>", "<c-\\><c-n>", term_opts)
keymap("t", "<leader>w", "<c-\\><c-n><c-w>", term_opts)

-- -- }}}
