" TODO:
" More colors for interesting-words
" More colors for Colorcoder
" Make comments more visible
" C++ tooling, e.g. CTags
" When exit with jk using easyescape, and the line is blank except for whitespace, pressing "." afterwards
"  doesn't repeat the action, because the jk exit does stuff (it deletes the whitespace).  Same problem I had
"  before with filling the default register with the deleted whitespace.
"
" What's causing the lag?
" * not neovim-colorcoder
" * not echodoc
" * Not any single line in the plug area, but commenting the whole thing out solves or makes it way rarer
" Is it just total load, rather than some single thing?
" Turning off relativenumber might help?
" I think switching to alacritty solved it.  Rewriting the screen in gnome terminal was sometimes slow, and
" both relativenumber and cursorline cause a lot of rewriting.  But in alacritty + compton, it's faster.



set modelines=0 " Because they're vulnerable
set cursorline
"set nocursorline
hi CursorLine guibg=#000000
set tabstop=4
set shiftwidth=4 " aka sw
set expandtab
set number
set relativenumber
"set norelativenumber
set tw=110 " Text width, for gqq et al
set formatoptions-=tc " Don't automatically wrap, even though tw!=0
set ignorecase " necessary for the next line.
set smartcase
set mouse=a
set background=dark " so vim can choose better colors
set termguicolors
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
set list " Display tabs
"set listchars=tab:>·,trail:·
set notimeout
set ttimeout
set completeopt-=preview " Don't show autocomplete in a split
set lazyredraw " Makes macros faster, among other things

" C and D act to end of line, Y should too
nmap Y y$

" Center the search hit so it's easier to see
nnoremap n nzzzv
nnoremap N Nzzzv

" Map f1 to esc because I usually hit it while trying to press esc
nmap <F1> <Esc>
imap <F1> <Esc>

" More typo reduction
"noremap q: :q

" Swap @ and q, because I (should) use q more
nnoremap @ q
nnoremap q @

" ctrl-q to run a macro in normal mode
inoremap <C-q> <C-o>@

" Easier than :w / :q sometimes
noremap <Leader>s :w<CR>
noremap <Leader>d :q<CR>

" Use hjkl to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use <Leader>r to redo syntax highlighting, if it's confused
noremap <Leader>r :syntax sync fromstart<CR>

" Swap words
nnoremap <silent> <Leader>w "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>:noh<CR>
"nnoremap gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>

" Three failed tries at a greek-letter hotkey
"inoremap <C-i> "<C-k>"nr2char(getchar())*

"inoremap <C-i> <C-k>*

"function! Greek()
"  let latin = input('Latin letter')
"  return "<C-k>".latin."*"
"endfunction
"inoremap <expr> <C-i> Greek()

" Have `cw` adhere to its actual movement `w`, instead of duplicating `ce`.
" Disabled because cw is easier to type than ce
nnoremap cw dwi
nnoremap cW dWi

" Jump to where you were if re-opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remember folds if you're re-opening file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Automatically reload files when they change on disk (warn if unsaved edits)
set autoread
au CursorHold * checktime

au BufNewFile,BufRead *.scad set filetype=c "Use C-style highlighting for openscad files
au BufNewFile,BufRead *.ino set filetype=cpp "Consider Arduino files as C++
au BufNewFile,BufRead *.pde set filetype=cpp "Consider Arduino files as C++
au BufNewFile,BufRead *.c set filetype=cpp "Consider C files C++ (!)
au BufNewFile,BufRead *.h set filetype=cpp "Consider C files C++ (!)
au BufNewFile,BufRead *.tpp set filetype=cpp "C++ template file
au BufNewFile,BufRead *.sage set filetype=python
au BufNewFile,BufRead *.fish set filetype=sh
au BufNewFile,BufRead *.shader set filetype=cpp

au BufNewFile,BufRead *.hs set expandtab "Expand tabs in Haskell files
" Format Python code 
" au BufWritePre *.py execute ':Black'

set foldmethod=syntax " Better for C++ and maybe in general
"autocmd FileType python set foldmethod=indent " Better for Python; disabled in favor of SimpylFold
autocmd FileType yaml set foldmethod=indent
set foldcolumn=0
" NOTE: If folding ever gets too slow, consider https://github.com/Konfekt/FastFold

" au BufWritePost *.go GoImports

" Keyboard shortcuts to format
au FileType python nnoremap <Leader>f :Black<cr>
au FileType cpp nnoremap <Leader>f :py3f /usr/share/clang/clang-format-6.0/clang-format.py<cr>

" let :W mean :w, and similar
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" clear highlighting on esc in normal mode
nnoremap <esc> :noh<return><esc>

" Ctrl-backspace deletes a word in insert mode
inoremap <C-H> <C-W>

" Ctrl-delete deletes a word forward in insert mode
inoremap <C-Del> <C-o>de

" Use ctrl-e and ctrl-d as ctrl-p and ctrl-n, because they're closer to each other and more intuitive
imap <C-E> <C-P>
imap <C-D> <C-N>

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
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 
let g:rainbow_conf = {'guifgs': ['lightslateblue', 'firebrick', 'royalblue3', 'darkorange3', 'seagreen3']}

" Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'kien/rainbow_parentheses.vim'
"autocmd VimEnter * RainbowParenthesesActivate
"autocmd VimEnter * RainbowParenthesesLoadRound


" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Chunk 2
Plug 'jamessan/vim-gnupg'
Plug 'joom/latex-unicoder.vim'
Plug 'psf/black', { 'tag': '19.10b0' } " Python formatter
"Plug 'psf/black' " Python formatter
"Set Black textwidth to Vim textwidth
let g:black_linelength = &textwidth
Plug 'vim-scripts/taglist.vim'
Plug 'mfulz/cscope.nvim'
"Plug 'severin-lemaignan/vim-minimap' " Doesn't seem to work, not sure why
"Plug 'wfxr/minimap.vim' " Requires nvim 0.5.0+ to work; I'm on 0.4.4 right now
"Plug 'majutsushi/tagbar'
Plug 'lfv89/vim-interestingwords' " ,k to highlight all instances of a word
" Way more interestingWords colors, though later ones are kinda dark
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222', '28','1','2','3','4','5','6','7','25','9','10','34','12','13','14','15','16','125','124','19']
let g:interestingWordsGUIColors = ['#ff0000', '#0000ff', '#00ff00', '#c88823', '#ff9724', '#ff2c4b', '#cc00ff', '#ff0088', '#00ccff', '#ffffff', '#aaaaaa']

" Chunk 3
Plug 'scrooloose/nerdcommenter' " Quick block commenting
Plug 'zhou13/vim-easyescape' " Escape with jk or kj
Plug 'tpope/vim-sleuth' " Automatic indentation
"Plug 'MattesGroeger/vim-bookmarks'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'leafgarland/typescript-vim'

" One kind of semantic highlighting.
"Plug 'jaxbot/semantic-highlight.vim' " highlight every var in a different color
"let g:semanticTermColors = [28,1,2,3,4,6,7,25,9,10,34,12,13,14,15,125,124]
"nnoremap <Leader>h :SemanticHighlightToggle<cr>

" Chunk 4
Plug 'blahgeek/neovim-colorcoder', { 'do' : ':UpdateRemotePlugins' } " Different semantic highlighting
let g:colorcoder_enable_filetypes = ['c', 'h', 'cpp', 'python', 'sh']
let g:colorcoder_saturation = 0.7

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
autocmd FileType text call deoplete#custom#option('auto_complete', v:false)
Plug 'deoplete-plugins/deoplete-jedi'

" Fn documentation -- re-enabled
Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
let g:echodoc#events = ["CompleteDone", "CursorMovedI"]
"autocmd FileType text let g:echodoc#enable_at_startup = 0
"let g:echodoc#type="virtual"
"let g:echodoc#type = 'floating'
" These two are useful for echodoc#type=echo
set shortmess+=c " Disable some messages that would overwrite the modeline
set noshowmode "Let echodoc work in echo mode, w/o overwriting it with -- INSERT --
" To use a custom highlight for the float window,
"change Pmenu to your highlight group
"highlight link EchoDocFloat Pmenu

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
"Plug 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
"Plug 'tomtom/tlib_vim'                    " dependencies #2
"Plug 'honza/vim-snippets'                 " snippets repo

"Plug 'chaoren/vim-wordmotion'
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'

"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

"Plug 'psliwka/vim-smoothie'
"let g:smoothie_experimental_mappings = 1

Plug 'michaeljsmith/vim-indent-object'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 400

Plug 'tommcdo/vim-exchange'
vmap <Leader>x <Plug>(Exchange)
nmap <Leader>x <Plug>(Exchange)
nmap <Leader>xx <Plug>(ExchangeLine)
nmap <Leader>xc <Plug>(ExchangeClear)
call plug#end()


" Turn on rust autofmt on safe.  Where the heck do we install rust, tho?
let g:rustfmt_autosave = 1


"" Snippets
"" TODO: Fix this.  It just prints the text, for some reason.
"" Enable snipMate compatibility feature.
"let g:neosnippet#enable_snipmate_compatibility = 1
"" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"xmap <C-k> <Plug>(neosnippet_expand_target)
"inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
"let g:neosnippet#enable_completed_snippet=1

"" For conceal markers.
"if has('conceal')
  "set conceallevel=2 concealcursor=niv
"endif
"

" For kien/rainbow_parentheses
"let g:rbpt_colorpairs = [
    "\ ['darkred',     'SeaGreen3'],
    "\ ['black',       'SeaGreen3'],
    "\ ['darkgreen',   'RoyalBlue3'],
    "\ ['darkcyan',    'SeaGreen3'],
    "\ ['brown',       'RoyalBlue3'],
    "\ ['Darkblue',    'SeaGreen3'],
    "\ ['darkgray',    'DarkOrchid3'],
    "\ ['gray',        'RoyalBlue3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['darkred',     'DarkOrchid3'],
    "\ ['Darkblue',    'firebrick3'],
    "\ ['brown',       'firebrick3'],
    "\ ['darkgreen',   'firebrick3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['darkcyan',    'RoyalBlue3'],
    "\ ['red',         'firebrick3'],
    "\ ]

" Let gitgutter work in larger files
let gitgutter_max_signs=5000

" Let latex-unicoder work in insert mode
inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
" Toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

" vim-pencil stuff; also turns on spell-checking for some filetypes
set nocompatible
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,text,rst call pencil#init() | set spell spl=en " en seems better than en_us
augroup END
autocmd FileType rst SoftPencil " Don't hard-wrap ReStructuredText files

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
" use gj and gk for textual lines, when e.g. writing a macro and repeatability is important
nnoremap gj j
nnoremap gk k

" Use f11 to toggle spellcheck
nnoremap <silent> <F11> :set spell!<cr>

" Make misspelled / rare works highlighted less aggressively
hi SpellBad ctermfg=015 ctermbg=016 cterm=none  guibg=#442222
hi SpellLocal ctermfg=015 ctermbg=000 cterm=none guibg=#224422
hi SpellCap ctermfg=015 ctermbg=000 cterm=none guibg=#224422

hi Folded guibg=#555555 guifg=Cyan

"" start cscope
"" autocmd BufRead,BufNewFile *.cpp CScopeStart /home/neophile/.cscope/cscope.cfg
"let g:cscope_dir = '~/.cscope'
"let g:cscope_map_keys = 1
"autocmd BufRead,BufNewFile *.c,*.cpp,*.h CScopeStart /home/neophile/.cscope/cscope.cfg
"autocmd BufRead,BufNewFile *.c,*.cpp,*.h cscope add /home/neophile/.cscope/cscope.out

