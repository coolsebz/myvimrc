"turn syntax highlighting
syntax on
" and show line numbers
set number

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" reload files changed outside vim
set autoread         

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" by default, in insert mode backspace won't delete over line breaks, or 
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" dont't unload buffers when they are abandoned, instead stay in the
" background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" ---------------------- CUSTOMIZATION ----------------------
"  The following are some extra mappings/configs to enhance my personal
"  VIM experience

" set , as mapleader
let mapleader = ","

" map <leader>q and <leader>w to buffer prev/next buffer
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

" windows like clipboard
" yank to and paste from the clipboard without prepending "* to commands
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
" map c-x and c-v to work as they do in windows, only in insert mode
vm <c-x> "+x
vm <c-c> "+y
cno <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']

" save with ctrl+s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" hide unnecessary gui in gVim
if has("gui_running")
    set guioptions-=m  " remove menu bar
    set guioptions-=T  " remove toolbar
    set guioptions-=r  " remove right-hand scroll bar
    set guioptions-=L  " remove left-hand scroll bar
end


" allow Tab and Shift+Tab to
" tab  selection in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv 

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default
" use ESC to remove search higlight
nnoremap <esc> :noh<return><esc>

" most of the time I should use ` instead of ' but typing it with my keyabord
" is a pain, so just toggle them
nnoremap ' `
nnoremap ` '

" suggestion for normal mode commands
set wildmode=list:longest

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" indentation
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=2  " operation >> indents 2 columns; << unindents 4 columns
set tabstop=2     " a hard TAB displays as 2 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=2 " insert/delete 2 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line


" use <C-Space> for Vim's keyword autocomplete
"  ...in the terminal
inoremap <Nul> <C-n>
"  ...and in gui mode
inoremap <C-Space> <C-n>

" On file types...
"   .md files are markdown files
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
"   .twig files use html syntax
autocmd BufNewFile,BufRead *.twig setlocal ft=html
"   .less files use less syntax
autocmd BufNewFile,BufRead *.less setlocal ft=less
"   .jade files use jade syntax
autocmd BufNewFile,BufRead *.jade setlocal ft=jade
".tpl files use ____ syntax
autocmd BufNewFile,BufRead *.tpl setlocal ft=jst 

" when pasting over SSH t's a pain to type :set paste and :set nopaste
" just map it to <f9>
set pastetoggle=<f9>

" if windows...
if has('win32')
    " start maximized
    autocmd GUIEnter * simalt ~x
    " also use .vim instead of vimfiles, make sure to run the following command
    " once this was copied to /Users/<user>/.vim
    "  mklink %homepath%/.vimrc %homepath%/.vim/.vimrc
    let &runtimepath.=',$HOME/.vim'
endif

" select all mapping
noremap <leader>a ggVG

" ---------------------- PLUGIN CONFIGURATION ----------------------
" initiate Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
" install plugins with :PluginInstall
Plugin 'gmarik/Vundle.vim'

" start plugin defintion
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'itchyny/lightline.vim'      
Plugin 'Lokaltog/vim-easymotion'    
Plugin 'tpope/vim-surround'         
" -- Web Development
" Plugin 'Shutnik/jshint2.vim'        
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'            
Plugin 'tpope/vim-fugitive'
" Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'mxw/vim-jsx'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
" Plugin 'nvie/vim-flake8'
Plugin 'othree/html5.vim'
      

" end plugin definition
call vundle#end()            " required for vundle

" start NERDTree on start-up and focus active window
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" map FuzzyFinder
noremap <leader>b :FufBuffer<cr>
noremap <leader>f :FufFile<cr>

" use zencoding with <C-E>
let g:user_emmet_leader_key = ','

" run JSHint when a file with .js extension is saved
" this requires the jsHint2 plugin
" autocmd BufWritePost *.js silent :JSHint

" set the color theme to monokai
" syntax enable
colorscheme molokai


"set colorcolumn=80
" and set the mark color to DarkSlateGray
"highlight ColorColumn ctermbg=lightgray guibg=lightgray
setlocal colorcolumn=

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

"set mapping for CtrlP pluggin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"attempt to fix .tpl syntax issue with smarty plugin
"au BufRead,BufNewFile *.tpl set filetype=smarty 

"easier movement between split panes"
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

"always do case incensitve search
set ic

"open vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
set timeoutlen=1000
set ttimeoutlen=0

"Use system clipboard
set clipboard=unnamed

"Better tabbing controls
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

