" TODO:
" Make comments more visible
" C++ tooling, e.g. CTags
" When exit with jk using easyescape, and the line is blank except for whitespace, pressing "." afterwards
"  doesn't repeat the action, because the jk exit does stuff (it deletes the whitespace).  Same problem I had
"  before with filling the default register with the deleted whitespace.
" Rewriting the screen in gnome terminal was sometimes slow, and both relativenumber and cursorline cause a
"  lot of rewriting.  But in alacritty + compton, it's faster.
" Autocomplete could be better.  Try coc.nvim?
" Startup could be faster.  About 150ms right now.
"   * Try lewis6991/impatient.nvim once I'm on neovim 0.7+
"   * https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/
"   * Once on 0.7+, switch to filetype.lua ('let g:do_filetype_lua = 1', 'let g:did_load_filetypes = 0')
" It would be nice if 'n' always searched forwards, and 'N' backwards, whether the original search was '/' or '?'.
" Fix semantic-highlighting Python after an @ sign used for matrix multiplication (the second argument gets highlighted bright blue like a
" function name after "def")
" vim-pencil breaks j and k (it makes them move a wrapped line even when preceded by a number).  Disabled, but it might do some nice things
"  (does it?).  PR or fork it?  The offending code is vim-pencil/blob/master/autoload/pencil.vim lines 415-418, pretty sure.
" vim-peekaboo map is a bit ugly.  Consider removing it, and instead setting peekaboo's prefix to <leader>?
" In command mode, bind alt+e to ctrl-f, for consistency with fish cmd line
" smoothie makes the cursor moves slower sometimes.  This is sometimes necessary, since the cursor can't be off the screen, but someitmes
"  happens when it wouldn't have to, e.g. gg or G when the beginning/end of the file is already in view.  Disabled experimental bindings
"  (gg, G), does this happen with any others?
" Smooth scrolling with search?
"   * smoothie doesn't work for search, or for page up / down.
"   * sexy_scroller.vim does n/N, but maybe causes artifacts?
"   * https://www.reddit.com/r/vim/comments/2sltnr/smooth_scroll_search_motions/
"   * https://github.com/karb94/neoscroll.nvim
"   * I do zz after my searches, so smoothie _should_ work, but it doesn't.  It seems a bit more complex than just, "running zvhn
"   immediately after zz makes the scroll finish early".

"let g:python3_host_prog = expand('/usr/bin/python3.8')

set modelines=0 " Because they're vulnerable
set tabstop=4
set shiftwidth=4 " aka sw
set noexpandtab
set number
set relativenumber
"set norelativenumber
set textwidth=140
set formatoptions-=t " Don't automatically wrap, even though tw!=0
set formatoptions-=c " Don't automatically wrap, even though tw!=0
set ignorecase " necessary for the next line.
set smartcase
set mouse=a
set background=dark " so vim can choose better colors
set termguicolors
set clipboard=unnamedplus " so the default yank/etc. buffer is "+ for system clipboard
filetype plugin indent on
set splitbelow " By default, open new windows below, not above
set splitright " By default, open new windows to the right, not left
set nofixeol " Don't automatically add an EOL at the end of the file
set undofile
set gdefault
let mapleader = ","
set scrolloff=4
"set listchars=tab:>·,trail:·
set notimeout
set ttimeout
set completeopt+=preview " show autocomplete in a menu
set completeopt+=longest " Insert the longest common prefix of all matches
set lazyredraw " Makes macros faster, among other things - but also makes search index not update when you press n or N if you also have the "nzzzv" bindings below
set updatetime=100
set statusline=%F\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P " Roughly same as stock, except %f -> %F shows the full path to the file being edited
let &showbreak = '↳ '
"set cpoptions+=n " Show the showbreak character in the line-number column -- doesn't seem to work?
set breakindent " When wrapping a line, indent the wrapped part the same amount that the line was indented
set linebreak " Word-wrapping, basically
set hidden " Allow switching buffers without saving or discarding changes

" C and D act to end of line, Y should too
nmap Y y$

" Center the search hit so it's easier to see - the hn fixes search count (e.g. "11/50" in the bottom bar), though it might break in the
" first column?
" Also, make n always go downwards, and N always upwards, regardless of whether / or ? was used to search
nnoremap <expr> n (v:searchforward ? 'nzzzvhn' : 'NzzzvhN')
nnoremap <expr> N (v:searchforward ? 'Nzzzvhn' : 'nzzzvhN')

" Map f1 to esc because I usually hit it while trying to press esc
nmap <F1> <Esc>
imap <F1> <Esc>

" More typo reduction
"noremap q: :q

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

" Use C-n and C-p to move between files
nnoremap <C-n> :n<CR>
nnoremap <C-p> :N<CR>


" Use s to open the cmd window
nnoremap s q:

" Use <Leader>r to redo syntax highlighting, if it's confused
noremap <Leader>r :syntax sync fromstart<CR>

" Swap words
nnoremap <silent> <Leader>p "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>:noh<CR>
"nnoremap gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>

" Hotkey to reload the spell file, because it's synced between computers
nnoremap <leader>m mkspell! ~/.config/nvim/spell/en.utf-8.add

" For consistency with fish, use alt-e to edit command in window, rather than ctrl-f
cmap <M-e> <C-f>

" Three failed tries at a greek-letter hotkey
"inoremap <C-i> "<C-k>"nr2char(getchar())*

"inoremap <C-i> <C-k>*

"function! Greek()
"  let latin = input('Latin letter')
"  return "<C-k>".latin."*"
"endfunction
"inoremap <expr> <C-i> Greek()

" Have `cw` adhere to its actual movement `w`, instead of duplicating `ce`.
" Disabled because cw is easier to type than ce, and because the old way to do it messed up repetition (.) and I don't
" know a better way to do it
"nnoremap cw ce
"nnoremap cW cE

set cursorline
hi CursorLine guibg=#303030
set cursorcolumn
hi CursorColumn guibg=#303030
" cursorlineopt=screenline,number
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

" Jump to where you were if re-opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remember folds if you're re-opening file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Automatically reload files when they change on disk (warn if unsaved edits); triggers after the user doesn't do anything for a moment
" (CursorHold).
set autoread
au CursorHold * silent! checktime " The silent! prevents a bunch of warnings when editing the command window (q:)

au BufNewFile,BufRead *.scad set filetype=c "Use C-style highlighting for openscad files
au BufNewFile,BufRead *.ino set filetype=cpp "Consider Arduino files as C++
au BufNewFile,BufRead *.pde set filetype=cpp "Consider Arduino files as C++
au BufNewFile,BufRead *.c set filetype=cpp "Consider C files C++ (!)
au BufNewFile,BufRead *.h set filetype=cpp "Consider C files C++ (!)
au BufNewFile,BufRead *.tpp set filetype=cpp "C++ template file
au BufNewFile,BufRead *.sage set filetype=python
au BufNewFile,BufRead *.fish set filetype=sh
au BufNewFile,BufRead *.shader set filetype=cpp
au BufNewFile,BufRead *.hy set filetype=lisp

au BufNewFile,BufRead *.hs set expandtab "Expand tabs in Haskell files

set foldmethod=syntax " Better for C++ and maybe in general
autocmd FileType python set foldmethod=indent " Better than syntax for Python
autocmd FileType python setlocal shiftwidth=4 tabstop=4 " To agree with Black
autocmd FileType python set list " Display tab characters
autocmd FileType yaml,text set foldmethod=indent
set foldcolumn=0
"let g:pymode_folding = 1


" Keyboard shortcuts to format
au FileType python nnoremap <Leader>f :Black<cr>
au FileType cpp nnoremap <Leader>f :py3f /usr/share/clang/clang-format-6.0/clang-format.py<cr>

" let :W mean :w, and :Q mean :q
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

" Highlight stuff that gets yanked.  Replaces the vim-highlightedyank plugin
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400}
augroup END

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
Plug 'vim-scripts/taglist.vim'
Plug 'mfulz/cscope.nvim', {'for': ['c', 'cpp']}
Plug 'wfxr/minimap.vim', {'on': 'Minimap'} " Requires nvim 0.5.0+ to work
Plug 'scrooloose/nerdcommenter' " Quick block commenting
Plug 'michaeljsmith/vim-indent-object'
Plug 'Konfekt/FastFold'

Plug 'junegunn/vim-peekaboo'
" Swap @ and q, because I (should) use q more
" NOTE: In vim-peekaboo/plugin/peekaboo.vim, change the mapping from @ to q
nnoremap @ q


" I think I disabled this because it conflicted with semantic highlighting, even with pymode_syntax_all=0
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"let g:pymode_options_max_line_length = &textwidth
"let g:pymode_options_colorcolumn = 0
"let g:pymode_lint_on_write = 0
""let g:pymode_syntax_space_errors = 0 " Disable highlighting trailing spaces (because I already do it more subtly)
"let g:pymode_syntax_all = 0 " Disable all syntax highlighting

Plug 'wellle/context.vim'
let g:context_highlight_tag = '<hide>'
" TODO: Switch to this once on 0.7
"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'airblade/vim-gitgutter'
"Plug 'lewis6991/gitsigns.nvim' " Note the lua call after plug#end, to turn this on

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['lightslateblue', 'firebrick', 'royalblue3', 'darkorange3', 'seagreen3', 'darkorchid3', 'darkgoldenrod2']}

Plug 'psf/black', {'tag': '19.10b0', 'on': 'Black'} " Python formatter
let g:black_linelength = &textwidth "Set Black textwidth to Vim textwidth

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" Toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

Plug 'lfv89/vim-interestingwords' " ,k to highlight all instances of a word
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222', '28','1','2','3','4','5','6','7','25','9','10','34','12','13','14','15','16','125','124','19']
let g:interestingWordsGUIColors = ['#ff0000', '#5555ff', '#00ff00', '#c88823', '#ff9724', '#ff2c4b', '#cc00ff', '#ff0088', '#00ccff', '#ffffff', '#aaaaaa']
let g:interestingWordsDefaultMappings = 0
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
nnoremap <silent> <leader>n :call WordNavigation(1)<cr>
nnoremap <silent> <leader>N :call WordNavigation(0)<cr>

" NOTE: easyescape seems slow to start, so if you load it on startup, it slows down startup by a lot (~100ms).  I think it's because it
" requires python3 to be started, or something.  Unfortunately I haven't yet found a way to fix this, so instead lazy-load on entering
" insert mode.  This also introduced a lag, but it seems more tolerable this way.
Plug 'zhou13/vim-easyescape', {'on': []} " Escape with jk or kj
Plug 'aselker/vim-easy-ctrl-o' " Ctrl-o with cv or vc

augroup load_on_insert " Load easyescape (and maybe others later!) on first entering insert mode
  autocmd!
  autocmd InsertEnter * call plug#load('vim-easyescape') " Can add stuff here in a comma-separated list
                     \| autocmd! load_on_insert
augroup END

Plug 'timakro/vim-yadi', { 'branch': 'main' } " Automatic indentation
autocmd BufRead * DetectIndent " run vim-yadi

Plug 'blahgeek/neovim-colorcoder', { 'do' : ':UpdateRemotePlugins' } " Semantic highlighting
let g:colorcoder_enable_filetypes = ['c', 'h', 'cpp', 'python', 'sh']
let g:colorcoder_saturation = 0.7

" Disabled in favor of deoplete
"Plug 'ycm-core/YouCompleteMe'
""let g:loaded_youcompleteme = 1 # Disable YouCompleteMe

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
autocmd FileType text let g:deoplete#enable_at_startup = 0
Plug 'deoplete-plugins/deoplete-jedi'

" Disabled because it causes lag.
" NOTE: This conflicts with python-mode
"Plug 'davidhalter/jedi-vim'
"let g:jedi#goto_command = "<leader>a" " Defaults to <leader>d
"let g:jedi#goto_stubs_command = "<leader>v" " Defaults to <leader>s
"let g:jedi#use_splits_not_buffers = "left"

" This doesn't seem to work...
"Plug 'Shougo/echodoc.vim'
"let g:echodoc#enable_at_startup = 1
"let g:echodoc#events = ["CompleteDone", "CursorMovedI"]
"autocmd FileType text let g:echodoc#enable_at_startup = 0
"let g:echodoc#type="virtual"
"let g:echodoc#type = 'floating'
" These two are useful for echodoc#type=echo
set shortmess+=c " Disable some messages that would overwrite the modeline
set noshowmode "Let echodoc work in echo mode, w/o overwriting it with -- INSERT --
"set cmdheight=2
" To use a custom highlight for the float window,
"change Pmenu to your highlight group
"highlight link EchoDocFloat Pmenu

Plug 'hylang/vim-hy'
let g:hy_enable_conceal=1 " This also highlights concealed chars, for some reason, so override that.
highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
Plug 'atisharma/vim-hyfold'

Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'

Plug 'tommcdo/vim-exchange'
vmap <Leader>x <Plug>(Exchange)
nmap <Leader>x <Plug>(Exchange)
nmap <Leader>xx <Plug>(ExchangeLine)
nmap <Leader>xc <Plug>(ExchangeClear)

Plug 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

Plug 'psliwka/vim-smoothie'
"let g:smoothie_experimental_mappings = 1 " gg and G

" Disabled plugins
"Plug 'karb94/neoscroll.nvim' " Note the lua call after plug#end.  This doesn't seem to work, though.
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'MattesGroeger/vim-bookmarks'
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"Plug 'tmhedberg/SimpylFold'
"Plug 'chaoren/vim-wordmotion'
"Plug 'jamessan/vim-gnupg'
"Plug 'joom/latex-unicoder.vim'
call plug#end()
"lua require('gitsigns').setup()
"lua require('neoscroll').setup()

" Turn on rust autofmt on safe.  Where the heck do we install rust, tho?
let g:rustfmt_autosave = 1

" au BufWritePost *.go GoImports

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

" Let gitgutter work in larger files
let gitgutter_max_signs=5000

" Let latex-unicoder work in insert mode
"inoremap <C-l> <Esc>:call unicoder#start(1)<CR>

" vim-pencil stuff; also turns on spell-checking for some filetypes
" Disabled because it messes with j and k
set nocompatible
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,text,rst call pencil#init()
  autocmd FileType markdown,mkd,text,rst set spell spl=en " en seems better than en_us.  Does this belong in the pencil group?
augroup END

" j and k go by visible (maybe wrapped) lines, not textual ones, unless there's a number (e.g. 4j)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <expr> <Down> v:count ? 'j' : 'gj'
nnoremap <expr> <Up> v:count ? 'k' : 'gk'


" Use f11 to toggle spellcheck
nnoremap <silent> <F11> :set spell!<cr>

" Make misspelled / rare works highlighted less aggressively
hi SpellBad ctermfg=015 ctermbg=016 cterm=none  guibg=#552222
hi SpellLocal ctermfg=015 ctermbg=000 cterm=none guibg=#224422
hi SpellCap ctermfg=015 ctermbg=000 cterm=none guibg=#224422

hi Folded guibg=#555555 guifg=Cyan

"" start cscope
"" autocmd BufRead,BufNewFile *.cpp CScopeStart /home/neophile/.cscope/cscope.cfg
"let g:cscope_dir = '~/.cscope'
"let g:cscope_map_keys = 1
"autocmd BufRead,BufNewFile *.c,*.cpp,*.h CScopeStart /home/neophile/.cscope/cscope.cfg
"autocmd BufRead,BufNewFile *.c,*.cpp,*.h cscope add /home/neophile/.cscope/cscope.out



" Function to permanently delete views created by 'mkview' (and also close without saving the view)
" Mostly copied from StackOverflow user David Ljung Madison Stellar
" https://stackoverflow.com/questions/28384159/vim-how-to-remove-clear-views-created-by-mkview-from-inside-of-vim
function! MyDeleteView()
  let path = fnamemodify(bufname('%'),':p')
  " vim's odd =~ escaping for /
  let path = substitute(path, '=', '==', 'g')
  if empty($HOME)
  else
  	let path = substitute(path, '^'.$HOME, '\~', '')
  endif
  let path = substitute(path, '/', '=+', 'g') . '='
  " view directory
  let path = &viewdir.'/'.path
  call delete(path)
  echo "Deleted: ".path
  " Exit without saving view
  augroup remember_folds
    autocmd!
  augroup END
  q
endfunction

" # Command Delview (and it's abbreviation 'delview')
command Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>
