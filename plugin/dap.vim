function! s:init_dap() abort
  if exists('g:loaded_dap')
    echom "DAP was already added previously!"
    echom "Disconnecting..."
    lua << EOF
    local ok, dap = pcall(require, 'dap')
    if not ok then
      return
    end
    dap.close()
    dap.disconnect()
EOF
    return
  endif
  packadd! nvim-dap
  packadd! nvim-dap-ui
  packadd! nvim-dap-virtual-text
  lua require'vec.config.dap'
  nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
  nnoremap <silent> <leader>ds :lua require'dap'.close()<CR>
  nnoremap <silent> <leader>dk :lua require'dap'.up()<CR>
  nnoremap <silent> <leader>dj :lua require'dap'.down()<CR>
  nnoremap <silent> <leader>dn :lua require'dap'.step_over()<CR>
  nnoremap <silent> <leader>di :lua require'dap'.step_into()<CR>
  nnoremap <silent> <leader>do :lua require'dap'.step_out()<CR>
  nnoremap <silent> <leader>dg :lua require'dap'.run_to_cursor()<CR>
  nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  nnoremap <silent> <leader>dr :lua require'dapui'.toggle('tray')<CR>
  nnoremap <silent> <leader>d/ :lua require'dapui'.toggle('sidebar')<CR>
  nnoremap <silent> <leader>de :lua require'dapui'.eval()<CR>
  vnoremap <silent> <leader>de <Cmd>lua require("dapui").eval()<CR>
  nnoremap <silent> <leader>dv :lua require'dapui'.float_element('scopes', {enter = true})<CR>
  nnoremap <silent> <leader>dl :DapVirtualTextForceRefresh<CR>

  let g:loaded_dap = 1
  echom "DAP added!"
endfunction

command! DAPInit call <SID>init_dap()
nnoremap <silent> <leader>dd :DAPInit<cr>
