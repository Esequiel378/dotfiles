" Default editor theme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_invert_selection=0
colorscheme gruvbox
set background=dark


" ============================================================================ "
" ===                             Custom Functions                         === "
" ============================================================================ "

function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Switch dark/light background
function! Solar_swap()
  if &background ==? 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction


" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" Key binding to switch background color
nmap <leader>bc :call Solar_swap()<CR>


" ============================================================================ "
" ===                             GROUPS                                   === "
" ============================================================================ "

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END
