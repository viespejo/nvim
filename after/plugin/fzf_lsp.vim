" vim: set sw=2 ts=2 sts=2 foldmethod=marker:

if !exists('g:loaded_fzf_lsp') || !exists('g:loaded_fzf_vim')
  finish
endif

" mappings
nnoremap <silent> <leader>cd :Definitions<cr>
nnoremap <silent> <leader>cD :Declarations<cr>
nnoremap <silent> <leader>cr :References<cr>
nnoremap <silent> <leader>ce :Diagnostics<cr>
nnoremap <silent> <leader>cs :DocumentSymbols<cr>
