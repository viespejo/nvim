local utils = require 'vec.config.utils'
local opt = utils.opt

-- :help options
opt('backup', false)                          -- creates a backup file
opt('writebackup', false)                     -- backup before overwriting a file
opt('clipboard', 'unnamedplus')               -- allows neovim to access the system clipboard: d, y, p, P using CLIPBOARD ["+] [unnamedplus]
opt('path', '.,**')                           -- |:find|, |:sfind|, |:tabfind| and other commands
opt('splitbelow', true)                       -- force all horizontal splits to go below current window
opt('splitright', true)                       -- force all vertical splits to go to the right of current window
opt('completeopt', 'menuone,noinsert,noselect') -- mostly just for cmp
opt('list', true)
opt('shiftwidth', 2)                          -- the number of spaces inserted for each indentation
opt('tabstop', 2)                             -- insert 2 spaces for a tab
opt('softtabstop', 2)                         -- number of spaces that a <Tab> counts for while performing editing operations
opt('expandtab', true)                        -- convert tabs to spaces
opt('breakindent', true)                      -- every wrapped line will continue visually indented
opt('showbreak', '↳ ')                        -- string to put at the start of lines that have been wrapped
opt('hidden', true)                           -- allow switching buffers without writting to disk
opt('ignorecase', true)                       -- ignore case in search patterns
opt('smartcase', true)                        -- smart case
opt('colorcolumn', '80')                      -- column highlighted
opt('number', true)                           -- set numbered lines
opt('numberwidth', 4)                         -- set number column width to 2 {default 4}
opt('termguicolors', true)                    -- set term gui colors (most terminals support this)
opt('timeoutlen', 1200)                       -- time to wait for a mapped sequence to complete (in milliseconds)
opt('undofile', true)                         -- enable persistent undo
opt('tags', './tags;/')                       -- ctag
opt('showmode', false)                        -- we don't need to see things like -- INSERT -- anymore
--opt('showtabline', 2)                         -- always show tabs
opt('signcolumn', "yes")                      -- always show the sign column, otherwise it would shift the text each time
--opt('cmdheight', 2)                           -- more space in the neovim command line for displaying messages
opt('mouse', "a")                             -- allow the mouse to be used in neovim
opt('pumheight', 10)                          -- pop up menu height
opt('smartindent', true)                      -- make indenting smarter again
opt('swapfile', false)                        -- creates a swapfile
opt('updatetime', 300)                        -- faster completion (4000ms default)
opt('cursorline', true)                       -- highlight the current line
opt('wrap', false)                            -- display lines as one long line
--opt('scrolloff', 8)                           -- is one of my fav
opt('sidescrolloff', 8)
opt('shada', [['50,<50,s10,h,/100]])          -- shada options
vim.opt.listchars = {                         -- strings to use in list mode
  tab = '→.',
  trail = '·',
  eol = '¬',
  extends = '…',
  precedes = '…'
}
vim.opt.shortmess:append('c')            -- default vertical split for diff mode
vim.opt.diffopt:append('vertical')            -- default vertical split for diff mode
