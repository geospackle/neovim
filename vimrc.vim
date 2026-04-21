"at startup
autocmd VimEnter * VtrAttachToPane 1
set nocompatible             " required
filetype off                  " required
syntax on
"https://stevelosh.com/blog/2010/09/coming-home-to-vim/
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set relativenumber
set undofile
set number
set incsearch
set hlsearch
set termguicolors
set laststatus=2
set novisualbell
set background=dark
" Enable folding
set foldmethod=indent
set foldlevel=99
"looks for :find matches in subfolders
set path+=** 
" case insensitive search for lowercase searches
set ignorecase
set smartcase
" list of folders to ignore w vimgrep
set wildignore=*/node_modules/*,*/tmp/*

filetype off
filetype plugin indent on    " required

if has('persistent_undo')         "check if your vim version supports
  set undodir=$HOME/.vim/undo     "directory where the undo files will be stored
  set directory=$HOME/.vim/swap
  set undofile                    "turn on the feature
endif

"set clipboard=unnamedplus   "system clipboard
set clipboard=unnamed   "system clipboard
" linting preferences visual needed to set in gruvbox.vim directly

let g:LanguageClient_useVirtualText = 0
" disable vim-go mappings
let g:go_def_mapping_enabled = 0
let g:pymode_lint_ignore = "E501,W"
"see docstrings for folded code
let g:SimpylFold_docstring_preview=1
let g:usemarks=0 "turn off placeholders for lh-brackets
" since it is fullscreen, I'd like a 50/50 split
let g:codi#width = winwidth(winnr()) / 2

"go
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_fields = 1
let g:go_def_mapping_enabled = 0
"let g:go_fmt_command = "gofmt"
let g:go_imports_autosave = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_code_completion_enabled = 0


"vim-surround
let g:surround_no_mappings=1
let g:surround_no_insert_mappings=1

" required for vim-tmux-runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

":WipeReg to wipe registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

let NERDTreeIgnore=['\.pyc$', '\~$'] 

" vim cell-mode parameters
let g:cellmode_use_tmux=1
let g:cellmode_tmux_panenumber=1

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

"remaps
map ; :
nmap = <C-W>=
inoremap <silent>jj <ESC>:w<CR>
nnoremap - $
nnoremap <leader><CR> o<Esc>
nnoremap <space> i
nnoremap ,bw :vs<CR> :bp<CR> L :bw<CR>
nnoremap vs :vs<CR>
nnoremap <leader>d "_d
nnoremap c "_c
nnoremap x "_x
 
"tabs
"A-L A-H
nnoremap <S-H> :bprev<CR>
nnoremap <S-L> :bnext<CR>
nnoremap <A-H> :tabprevious<CR> 
nnoremap <A-L> :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
"A-J A-K
nnoremap <silent> ∆ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> ˚ :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap ts :tab split<CR>

nnoremap ,rn :set rnu!<CR>

nmap <C-L> <C-W>l
nmap <C-H> <C-W>h
"nmap <C-N> <C-E>

nnoremap ,c :Codi!!<CR> 

" search visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

nnoremap ,rc :tabnew ~/.config/nvim/vimrc.vim<CR> :vsplit ~/.config/nvim/init.lua<CR> :vsplit ~/.config/nvim/lua/keybindings.lua<CR> :lcd ~/.config/nvim<CR>
nnoremap ,src :luafile ~/.config/nvim/init.lua<CR>

"vim-surround
"d' c'" yw" 
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
" line wise
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround
if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
  imap <C-S> <Plug>Isurround
endif
imap <C-G>s <Plug>Isurround
imap <C-G>S <Plug>ISurround

"mock mappings to avoid conflicts
map qwe <Plug>MarkersJumpB
map ert <Plug>MarkersJumpF
map rty <Plug>MarkersMark
map uio <Plug>MarkersJumpOutside
map yui <Plug>MarkersCloseAllAndJumpToLast

"nnoremap <Leader>l :let word=expand('<cword>')<CR> | :execute 'put! =printf(''console.log(%s)'', word)'
nnoremap ,ri :VtrOpenRunner {'orientation': 'v', 'percentage': 30, 'cmd': 'ipython\ --no-autoindent'}<CR><CR>
noremap ,cdc :call VtgGoToCurrentDir()<CR>
noremap ,cdw :call VtrGoToWorkingDir()<CR>
noremap ,rt :VtrSendCommandToRunner !!<CR>
noremap ,rr :VtrSendCommandToRunner ''<CR>
noremap ,rf :w<CR> :VtrSendCommandToRunner poetry run python %<CR>
noremap ,rl :VtrSendLinesToRunner<CR> 
noremap ,rll :VtrSendLinesToRunner<CR><CR> 
noremap ,rp vip :VtrSendLinesToRunner<CR> 
noremap ,ap :VtrAttachToPane<CR>
" if the next two are piped, reads before write is finished(?)
noremap ,we :VtrSendCommandToRunner %store "str('firefox\u0020-new-tab\u0020-url\u0020https://www.google.com/search?q=')+str('\"')+re.findall('\'.+?\'',str(type(sys.last_value)))[0]+str('\u0020')+re.sub(r'\(.+?\)','',str(sys.last_value))+str('\"')" >~/ipy_error.sh<CR> <bar> :! chmod 755 ~/ipy_error.sh<CR><CR>
noremap ,re :! ~/ipy_error.sh<CR><CR>
noremap ,cc :VtrSendCtrlC<CR>

"return cursor to last known position
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


"web dev
autocmd FileType css setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au FileType go nmap <buffer> ,re <Esc>:w<CR>:VtrSendCommandToRunner APP_ENV=qa-local-write ./scripts/dev_build.sh<CR>
au FileType go nmap <buffer> ,gr <Esc>:w<CR>:w !go run %<CR>

function! RunGoFile()
  let var = @% 
  return ':VtrSendCommandToRunner go run '.var
endfunction

"https://github.com/hdfelix/dotfiles/blob/master/vimrc
function! VtrGoToCurrentDir()
  let dir = expand('%:p:h') 
  execute ':VtrSendCommandToRunner cd '.dir
endfunction

function! VtrGoToWorkingDir()
  let dir = getcwd() 
  execute ':VtrSendCommandToRunner cd '.dir
endfunction
