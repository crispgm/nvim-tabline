if exists('g:loaded_nvim_tabline')
  finish
endif

let g:loaded_nvim_tabline = 1

lua require'tabline'.setup{}
