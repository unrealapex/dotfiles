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
set history=500
" ignore case unless explicitly stated
set ignorecase
" incremental search
set incsearch
set laststatus=2
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

highlight clear SignColumn

" keybindings

" change map leader to space
let mapleader=" "

" line/selection movement binds
" alt + k to move a line or selection up,
" alt + j to move a line or selection down
" amazing vim hack taken from the wiki:
" https://vim.fandom.com/wiki/Moving_lines_up_or_down#:~:text=In%20normal%20mode%20or%20in,to%20move%20the%20block%20up.
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


nnoremap <leader>cd :cd %:p:h <Bar> echo getcwd()<CR>


nnoremap Y y$
nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
xnoremap * y/\V<C-R>"<CR>
xnoremap # y?\V<C-R>"<CR>
nnoremap & :&&<CR>


" efficient editing in insert mode
" map ctrl + backspace to delete the previous word in insert mode
imap <C-BS> <C-W>
" map shift + tab to unindent
inoremap <S-Tab> <C-d>

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>



" vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  :echo "Installing Vim Plug"
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  :echo "Vim Plug installed"
endif

call plug#begin('~/.vim/plugged')
" file explorer
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch', {'on': [
\  'Remove',
\  'Unlink',
\  'Delete',
\  'Copy',
\  'Duplicate',
\  'Move',
\  'Rename',
\  'Chmod',
\  'Mkdir',
\  'Cfind',
\  'Lfind',
\  'Clocate',
\  'Llocate',
\  'SudoEdit',
\  'SudoWrite',
\  'Wall',
\  'W',
\  ]
\ }
Plug 'tpope/vim-unimpaired'
" show git changes in gutter
Plug 'airblade/vim-gitgutter'
Plug 'romainl/vim-cool'
Plug 'wellle/context.vim'
" git integration
Plug 'tpope/vim-fugitive'
" Vim Surround
Plug 'tpope/vim-surround'
" Vim Commentary
Plug 'tpope/vim-commentary'
" Goyo
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
" colored parantheses
Plug 'junegunn/rainbow_parentheses.vim'
" code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'} | Plug 'honza/vim-snippets'
Plug 'tpope/vim-repeat'
" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" icons
Plug 'ryanoasis/vim-devicons'
call plug#end()

" enable RainbowParentheses
augroup rainbow_parens
  autocmd!
  autocmd VimEnter * RainbowParentheses
augroup end

" plugin configs

" CoC configurations

" CoC Extensions
let g:coc_global_extensions = [
\  'coc-vimlsp',
\  'coc-sumneko-lua',
\  'coc-sh',
\  'coc-pyright',
\  'coc-clangd',
\  'coc-java',
\  'coc-sql',
\  'coc-html',
\  'coc-html-css-support',
\  'coc-tsserver',
\  'coc-css',
\  'coc-json',
\  'coc-snippets',
\  'coc-lightbulb',
\  'coc-calc',
\  'coc-emoji',
\ ]

" CoC keybindings

" map tab to accept completion
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

inoremap <silent><expr> <c-space> coc#refresh()

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)<CR>
nmap <silent> gy <Plug>(coc-type-definition)<CR>

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)<CR>

" gr - find references
nmap <silent> gr <Plug>(coc-references)<CR>

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" list errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" list commands available in tsserver (and others)
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" view all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

" rename the current word in the cursor
nmap <leader>rn  <Plug>(coc-rename)<CR>
nmap <F2> <Plug>(coc-rename)<CR>
nmap <leader>cf  <Plug>(coc-format-selected)<CR>
vmap <leader>cf  <Plug>(coc-format-selected)<CR>

" run code actions
vmap <leader>ca  <Plug>(coc-codeaction-selected)<CR>
nmap <leader>ca  <Plug>(coc-codeaction-selected)<CR>


nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

nnoremap [d <Plug>(coc-diagnostic-prev)<CR>
nnoremap ]d <Plug>(coc-diagnostic-next)<CR>


" FZF configurations

" open FZF file search when ctrl + p is pressed
nnoremap <leader>ff :Files<CR>
" open FZF ripgrep search when ctrl + t is pressed
nnoremap <leader>fg :Rg<CR>


nnoremap <leader>z :Goyo<CR>


" disable coc warning
let g:coc_disable_startup_warning = 1
