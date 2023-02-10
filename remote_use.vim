" my vimrc for remote use(no plugins)
" vim -Nu <(curl https://raw.githubusercontent.com/UnrealApex/dotfiles/main/remote_use.vim)


colorscheme elflord
" automatic indentation
set autoindent
" reread file if it has been modified outside of Vim
set autoread
" set window background to dark
set background=dark
" more powerful backspacing
set backspace=indent,eol,start
" enter the current millennium
set nocompatible
set completeopt=menu,menuone,noselect
" enable cursor line
set cursorline
" disable annoying error bell
set noerrorbells
set expandtab
set fo+=jpor
" enable folding
set nofoldenable
set foldmethod=indent
" allow hidden buffers
set hidden
" ignore case unless explicitly stated
set ignorecase
" incremental search
set incsearch
set list
set listchars=
set magic
" show line numbers
set number
" basic completion
set omnifunc=syntaxcomplete#Complete
set path+=.,**
set pumheight=15
" show relative line numbers
set relativenumber
" show cursor position in status bar
set ruler
" 8 lines above or below cursor when scrolling
set scrolloff=8
" indents to next multiple of 'shiftwidth'.
set shiftwidth=2
set shiftround
set noshowmode
" show typed command in status bar
set showcmd
set signcolumn=yes
set smartcase
" set tabs to two spaces
set tabstop=2
set termguicolors
" show file in titlebar
set title
" set updatetime to 200 milliseconds
set updatetime=200
set novisualbell
set wildmenu
set wildmode=longest:full,full
" don't wrap lines
set nowrap


" change map leader to space
let mapleader=" "


" keymaps

" efficient editing in insert mode
" map ctrl + backspace to delete the previous word in insert mode
imap <C-BS> <C-W>
" map shift + tab to unindent
inoremap <S-Tab> <C-d>

nnoremap <leader>cd :cd %:p:h <Bar> echo getcwd()<CR>


" saner CTRL-L
nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" emulate vim vinegar
" disable annoying banner
let g:netrw_banner=0
" open in prior window
let g:netrw_browse_split=4
" open splits to the right
let g:netrw_altv=1
" tree view
let g:netrw_liststyle=3  
" hide files that are ignored by gitignore
let g:netrw_list_hide=netrw_gitignore#Hide()
" hide dotfiles by default
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
nnoremap - :Explore %:h<CR>


" line/selection movement binds
" alt + k to move a line or selection up,
" alt + j to move a line or selection down
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" buffer stuff
" switch buffers easily
nnoremap <leader>b :set nomore <Bar> echo ":buffers" <Bar> :ls <Bar> :set more <CR>:b<Space>
nnoremap <Leader>n :enew<CR>
nnoremap <Leader>q :bd<CR>

" Resize splits with alt + arrows
nnoremap <A-Up> :resize +2<CR>
nnoremap <A-Down> :resize -2<CR>
nnoremap <A-Left> :vertical resize -2<CR>
nnoremap <A-Right> :vertical resize +2<CR>

nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" don't lose selection when shifting text
xnoremap < <gv
xnoremap > >gv
