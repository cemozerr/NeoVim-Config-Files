set number                " Show linenumbers
syntax on                 " Syntax highlighting

set mouse=a
set expandtab
set softtabstop=4
set shiftwidth=4 
set splitbelow
set splitright

xnoremap p pgvy

" Map the leader key to SPACE
let mapleader="\<SPACE>"

highlight TermCursor ctermfg=blue guifg=blue

" Terminal settings
tnoremap <ESC> <C-\><C-n>

" vsp,sp opens new buffer
noremap :vsp :vsp:enew! 
noremap :sp :sp:enew! 

" get rid of unnnecessary strokes
nnoremap ; :
nnoremap Q @q

highlight clear LineNr
highlight LineNr ctermfg=grey ctermbg=black

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
noremap <silent> <leader>n :NERDTreeToggle<CR> <C-w>=
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction
autocmd BufEnter * call NERDTreeRefresh()
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
let g:NERDTreeUpdateOnCursorHold = 0

Plug 'tomlion/vim-solidity'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'chriskempson/base16-vim'

Plug 'ctrlpvim/ctrlp.vim', {'on': ['CtrlP', 'CtrlPMixed', 'CtrlPMRU']}
" Use CTRL-P for searching, also in Insert mode
noremap <C-m> :CtrlP<CR>
vnoremap <C-m> :CtrlP<CR>
let g:ctrlp_working_path_mode = 'ra'

let g:airline_theme = 'minimalist'
let g:indentLine_enabled = 0
noremap <silent> <leader>t :IndentLinesToggle<CR>

Plug 'neomake/neomake'
let g:neomake_open_list = 1
noremap <silent> <leader>m :Neomake<CR>

" Initialize plugin system
call plug#end()

" FUNCTIONS

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
autocmd BufLeave term://* stopinsert
autocmd BufWinEnter,WinEnter term://* startinsert
func! s:mapMoveToWindowInDirection(direction)
    func! s:maybeInsertMode(direction)
        stopinsert
        execute "wincmd" a:direction

        if &buftype == 'terminal'
            startinsert!
        endif
    endfunc

    execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                \ "<C-\\><C-n>"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
endfunc
for dir in ["h", "j", "l", "k"]
    call s:mapMoveToWindowInDirection(dir)
endfor


" Quickly switch between relative and normal numbering function
" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

