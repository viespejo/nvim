local utils = require 'vec.config.utils'
local autocmd = utils.autocmd

autocmd('vec_terminal', {'TermOpen * setlocal scl=no nonumber'})
autocmd(
  'vec_formatoptions',
  {'BufWinEnter * set fo-=r fo-=o'}
) -- no autoinsert comment on enter
