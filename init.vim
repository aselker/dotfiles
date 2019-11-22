set modelines=0 " Because they're vulnerable
set cursorline
set tabstop=2
set shiftwidth=2 " aka sw
set noexpandtab
set number
set relativenumber
" set tw=110 " Text width, for gqq et al
set ignorecase " necessary for the next line.
set smartcase
set mouse=a
set background=dark " so vim can choose better colors
set clipboard=unnamedplus " so the default yank/etc. buffer is "+ for system clipboard
filetype plugin indent on
autocmd FileType python setlocal shiftwidth=4 tabstop=4 " To agree with Black
set splitbelow " By default, open new windows below, not above
set splitright " By default, open new windows to the right, not left
set nofixeol " Don't automatically add an EOL at the end of the file
set undofile
set gdefault
let mapleader = ","
set scrolloff=4


" Use hjkl to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Jump to where you were if re-opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au BufNewFile,BufRead *.scad set filetype=c "Use C-style highlighting for openscad files
au BufNewFile,BufRead *.sage set filetype=python 
au BufNewFile,BufRead *.hs set expandtab "Expand tabs in Haskell files
" Format Python code 
au BufWritePre *.py execute ':Black'

set foldmethod=syntax " Better for C++ and maybe in general
" Better for Python, and maybe faster
autocmd FileType python set foldmethod=indent
set foldcolumn=1

" au BufWritePost *.go GoFmt " Unnecessary because GoImports runs gofmt
" au BufWritePost *.go GoImports

" let :W mean :w, and similar
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" clear highlighting on esc in normal mode
nnoremap <esc> :noh<return><esc>

" Ctrl-backspace deletes a word in insert mode
inoremap <C-H> <C-W>

" Use space to open / close folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zO
" vnoremap <Space> zf

" Ctags stuff
set tags=./tags;$HOME " Let ctags look up directories until it finds it, or hits ~
" Open definition in new tab
map <C-}> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open definition in vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"Set caps lock in insert mode using Ctrl+^ (Ctrl+Shift+6)
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor
"Set it to clear itself when we leave insert mode
autocmd InsertLeave * set iminsert=0

" Plug stuff
call plug#begin('~/.local/share/nvim/plugged')
Plug 'reedes/vim-pencil'
Plug 'airblade/vim-gitgutter'
" Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kien/rainbow_parentheses.vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jamessan/vim-gnupg'
Plug 'joom/latex-unicoder.vim'
Plug 'ambv/black' " Python formatter
Plug 'vim-scripts/taglist.vim'
Plug 'mfulz/cscope.nvim'
Plug 'severin-lemaignan/vim-minimap'
Plug 'majutsushi/tagbar'
Plug 'lfv89/vim-interestingwords'
Plug 'scrooloose/nerdcommenter' " Quick block commenting
Plug 'zhou13/vim-easyescape' " Escape with jk or kj
Plug 'tpope/vim-sleuth' " Automatic indentation
call plug#end()

let g:rbpt_colorpairs = [
    \ ['darkred',     'SeaGreen3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['brown',       'firebrick3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['red',         'firebrick3'],
    \ ]

" Let gitgutter work in larger files
let gitgutter_max_signs=5000

" Let latex-unicoder work in insert mode
inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
" Use raindow parens
autocmd VimEnter * RainbowParenthesesActivate
autocmd VimEnter * RainbowParenthesesLoadRound
" Toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

" vim-pencil stuff
set nocompatible
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
	" en_us incorrectly highlights \"Hello e.g. world\" as bad caps; en doesn't
  " autocmd FileType markdown,mkd call pencil#init() | set spell spl=en_us
  " autocmd FileType text         call pencil#init() | set spell spl=en_us 
  autocmd FileType markdown,mkd call pencil#init() | set spell spl=en
  autocmd FileType text         call pencil#init() | set spell spl=en 
augroup END

" Arrow key / direction config, after vim-pencil so it overrides that stuff
" I am arrow key nazi!  No arrow key for you!
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" j and k go by visible lines, not textual ones
nnoremap j gj
nnoremap k gk


" Make misspelled / rare works highlighted less aggressively
hi SpellBad ctermfg=015 ctermbg=016 cterm=none 
hi SpellLocal ctermfg=015 ctermbg=000 cterm=none
hi SpellCap ctermfg=015 ctermbg=000 cterm=none

"" start cscope
"" autocmd BufRead,BufNewFile *.cpp CScopeStart /home/neophile/.cscope/cscope.cfg
"let g:cscope_dir = '~/.cscope'
"let g:cscope_map_keys = 1
"autocmd BufRead,BufNewFile *.c,*.cpp,*.h CScopeStart /home/neophile/.cscope/cscope.cfg
"autocmd BufRead,BufNewFile *.c,*.cpp,*.h cscope add /home/neophile/.cscope/cscope.out

